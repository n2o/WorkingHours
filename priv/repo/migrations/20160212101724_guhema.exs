defmodule WorkingHours.Repo.Migrations.Entry do
  use Ecto.Migration

  def change do
    create table(:entry) do
      add :date, :string
      add :company, :string
      add :hours, :float, default: 0.0
      add :comment, :string
      timestamps
    end
  end
end
