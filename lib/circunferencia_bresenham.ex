defmodule CircunferenciaBresenham do
  @moduledoc """
  Algoritmo bresenham para el dibujo de circunferencias
  """
  @doc """
  Recibe un mapa con las coordenadas x, y del punto
  en el que empezará y el radio de la circunferencia

  ## Examples

      iex> CircunferenciaBresenham.start(%{x: 15, y: 0, r: 15})
      [{15,0}, {15,1}, ...]

  """
  def start(%{x: x, y: y, r: r}) do
    [{x, y} | crea_puntos(x, y, r, 1)]
  end

  def crea_puntos(x, y, _r, _iteracion) when y >= x, do: []

  def crea_puntos(x, y, r, iteracion) do
    IO.inspect(iteracion, label: "\nIteración")
    e = :math.pow(x,2) + :math.pow(y,2) - :math.pow(r,2)
    es = e + (2 * y) + 1
    ed = es - (2 * x) + 1

    IO.inspect(e, label: "Error")
    IO.inspect(es, label: "Error superior")
    IO.inspect(ed, label: "Error diagonal")
    case abs(es) < abs(ed) do
      true ->
        IO.inspect("|error_superior| < |error diagonal| ")
        IO.inspect("(#{x}, #{y + 1})", label: "(x,y + 1)")
        [{x, y + 1} | crea_puntos(x, y + 1, r, iteracion + 1)]
      false ->
        IO.inspect("|error_superior| >= |error diagonal| ")
        IO.inspect("(#{x - 1}, #{y + 1})", label: "(x - 1, y + 1)")
        [{x - 1, y + 1} | crea_puntos(x - 1, y + 1, r, iteracion + 1)]
    end

  end
end
