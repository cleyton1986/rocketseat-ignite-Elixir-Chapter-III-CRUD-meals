defmodule MealsMonitor.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias MealsMonitor.Meal

  @params [:nome, :email, :cpf]

  @derive {Jason.Encoder, only: [:id, :nome, :email, :cpf]}

  schema "users" do
    field :nome, :string, source: :name
    field :email, :string
    field :cpf, :string

    has_many :meals, Meal

    timestamps inserted_at: :data_cadastro,
               updated_at: :data_alteração,
               inserted_at_source: :inserted_at,
               updated_at_source: :updated_at
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @params)
    |> validate_required(@params)
    |> validate_length(:nome, min: 6, max: 100)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cpf, is: 11)
    |> unique_constraint(:email)
    |> unique_constraint(:cpf)
  end
end
