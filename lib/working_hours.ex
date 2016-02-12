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
