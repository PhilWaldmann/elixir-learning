defmodule Friends.People.Person do
  use Ecto.Schema
  import Ecto.Changeset
  import Friends.Collection.Group

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    belongs_to(:group, Friends.Group)

    embeds_one :address, Address do
      field :street_name, :string
      field :street_number, :integer
      field :city, :string
      field :country, :string
    end

  end

  # def address_changeset(address, attrs) do
  #   address
  #   |> cast(attrs, [:street_name, :street_number, :city, :country])
  #   |> validate_required([:street_name, :city, :country])
  # end


  def changeset(person, params \\ %{}) do
    person
    |> cast(params, [:first_name, :last_name, :age])
    |> cast_embed(:address, with: &address_changeset/2)
    |> validate_required([:first_name, :last_name])
    |> validate_length(:first_name, min: 2)
    |> validate_length(:last_name, min: 3)
    |> validate_inclusion(:age, 16..100)
  end
end
