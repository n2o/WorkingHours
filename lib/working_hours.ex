defmodule WorkingHours.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      supervisor(WorkingHours.Repo, [])
    ]
    opts = [name: WorkingHours.Supervisor, strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end

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

# {:ok, ecto_date} = Ecto.Date.cast("2016-02-12")
# WorkingHours.Repo.insert!(%Guhema{date: ecto_date, hours: 0.0, comment: "test"})

defmodule WorkingHours do
  def query() do
    import Ecto.Query, only: [from: 2]
    alias WorkingHours.{Repo, Hours}

    query = from hour in Hours,
      where: hour.company == "guhema",
      select: hour

    Repo.all(query)
  end

  def sample() do
    alias WorkingHours.{App, Repo}
    App.start(1, 2)
    entry = %WorkingHours.Hours{date: "2016-02-12", company: "guhema", hours: 0.0, comment: "Test"}
    Repo.insert!(entry)
  end
end
