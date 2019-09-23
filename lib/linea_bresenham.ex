defmodule LineasBresenham do
  @moduledoc """
  Invoca el algoritmo para dibujo de líneas.
  Recibe como parámetros dos mapas que contienen
  las coordenadas x, y de los puntos que conforman la linea
  """

  @doc """
  Inicio del algoritmo

  ## Examples

      iex> LineasBresenham.start(%{x: 2, y: 5},%{x: 9, y: 15})
      [{1,2}, {1,3}, ...]

  """
  def start(a, b) do
    case pendiente_positiva?(a, b) do
      {dy, dx, true} -> bresenham_linea(:positiva, dx, dy, a.x, a.y, b.x, b.y)
      {dy, dx, false} -> bresenham_linea(:negativa, dx, dy, a.x, a.y, b.x, b.y)
      _ -> IO.inspect("Error, pendiente indefinida")
    end
  end

  def pendiente_positiva?(a, b) do
    delta_y = (b.y - a.y)
    delta_x = (b.x - a.x)
    case delta_y / delta_x do
       pendiente when pendiente > 1 ->
        IO.inspect(pendiente, label: "Pendiente")
         {delta_y, delta_x, true}
      pendiente when pendiente < 1 ->
        IO.inspect(pendiente, label: "Pendiente")
        {delta_y, delta_x, false}
      _ -> :invalid
    end
  end

  def bresenham_linea(pendiente, dx, dy, x1, y1, x2, y2) do
    p1 = {x1, y1}
    p0 = primer_punto(dx, dy)

    case pendiente do
      :positiva -> [p1 | crea_puntos(:positiva, p0, x1, y1, x2, y2,dx, dy, 1)]
      :negativa -> [p1 | crea_puntos(:negativa, p0, x1, y1, x2, y2,dx, dy, 1)]

    end
  end
  def crea_puntos(_, _p0, x1, y1, x2 , y2,  _dx, _dy, _iter) when x1 == x2 and y1 == y2 do
    []
  end

  def crea_puntos(:negativa, p0, xi, yi, x2, y2, dx, dy, iter) do
    IO.inspect(iter, label: "\nIteración")
    case p0 < 0 do
      true ->
        IO.inspect("p0 < 0")
        IO.inspect("p0 + 2dy", label: "pi")
        x = xi + 1
        y = yi
        p0 =  p0 + 2*dy
        [{x, y} | crea_puntos(:negativa, p0, x, y, x2, y2, dx, dy, iter + 1)]
      false ->
        IO.inspect("p0 < 0")
        IO.inspect("p0 + 2dy - 2dx", label: "pi")
        x = xi + 1
        y = yi + 1
        p0 = p0 + 2*dy - 2*dx
        [{x, y} | crea_puntos(:negativa, p0, x, y, x2, y2, dx, dy, iter + 1)]
    end
  end

  def crea_puntos(:positiva, p0, xi, yi, x2, y2, dx, dy, iter) do
    IO.inspect(iter, label: "\nIteración")
    case p0 < 0 do
      true ->
        IO.inspect("p0 < 0")
        IO.inspect("p0 + 2dx", label: "pi")
        x = xi
        y = yi + 1
        p0 =  p0 + 2*dx
        IO.inspect(p0, label: "pi")
        [{x, y} | crea_puntos(:positiva, p0, x, y, x2, y2, dx, dy, iter + 1)]
      false ->
        IO.inspect("p0 >= 0")
        IO.inspect("p0 + 2dx -2dy", label: "pi")
        x = xi + 1
        y = yi + 1
        p0 = p0 + 2*dx - 2*dy
        IO.inspect(p0, label: "pi")
        [{x, y} | crea_puntos(:positiva, p0, x, y, x2, y2, dx, dy, iter + 1)]
    end
  end
  def primer_punto(inc1, inc2)  do
    2*inc1 - inc2
  end

end

