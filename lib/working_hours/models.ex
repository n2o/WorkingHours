defmodule WorkingHours.Hours do
  use Ecto.Schema
  import Ecto.Changeset

  schema "entry" do
    field :date
    field :company
    field :hours, :float, default: 0.0
    field :comment
    timestamps
  end

  @required_fields ~w(date company hours)
  @optional_fields ~w(comment)

  def changeset(guhema, params \\ :empty) do
    guhema
    |> cast(params, @required_fields, @optional_fields)
  end
end
