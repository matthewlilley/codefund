defmodule CodeSponsor.Schema.Campaign do
  use CodeSponsorWeb, :schema_with_formex

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "campaigns" do
    has_many :impressions, CodeSponsor.Schema.Impression
    has_many :clicks, CodeSponsor.Schema.Click
    belongs_to :user, CodeSponsor.Schema.User

    field :name, :string
    field :redirect_url, :string
    field :status, :integer, default: 1
    field :description, :string
    field :bid_amount, :decimal, default: Decimal.new(0.0)
    field :budget_daily_amount, :decimal, default: Decimal.new(0.0)
    field :budget_monthly_amount, :decimal, default: Decimal.new(0.0)
    field :budget_total_amount, :decimal, default: Decimal.new(0.0)
    field :fraud_check_url, :string

    timestamps()
  end

  @required [
    :user_id,
    :name,
    :redirect_url,
    :status,
    :bid_amount,
    :budget_daily_amount,
    :budget_monthly_amount,
    :budget_total_amount
  ]

  @doc false
  def changeset(%Campaign{} = campaign, params) do
    campaign
    |> cast(params, __MODULE__.__schema__(:fields) |> List.delete(:id))
    |> validate_required(@required)
  end
end
