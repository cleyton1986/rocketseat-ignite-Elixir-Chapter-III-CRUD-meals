defmodule MealsMonitor.Meal do
  use Ecto.Schema

  import Ecto.Changeset

  alias MealsMonitor.User

  @params [:descricao, :data, :calorias, :user_id]

  @derive {Jason.Encoder, only: [:id, :descricao, :data, :calorias, :user_id]}

  schema "meals" do
    field :descricao, :string, source: :description
    field :data, :naive_datetime, source: :date
    field :calorias, :decimal, source: :calories

    belongs_to :user, User
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @params)
    |> validate_required(@params)
    |> validate_length(:descricao, max: 100)
    |> validate_number(:calorias, less_than_or_equal_to: 100_000)
    |> foreign_key_constraint(:user_id)
  end
end
