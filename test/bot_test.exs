defmodule Test.Instex.Bot do
  use ExUnit.Case, async: false

  alias Test.Webhook
  import Test.Utils.{Const, Mock}

  setup_all {Test.Utils.Mock, :setup_tesla_mock_global_async}
  setup :setup_test_bot

  test "basic flow" do
    url_test_response = tg_url(tg_token(), "testResponse")

    assert {:ok, _} =
             Webhook.update(tg_token(), %{
               "update_id" => 1,
               "message" => %{"text" => "/command"}
             })

    assert :ok ==
             tesla_mock_assert_request(
               %{method: :post, url: ^url_test_response},
               fn _request ->
                 response = %{"ok" => true, "result" => "ok"}
                 Tesla.Mock.json(response, status: 200)
               end,
               false
             )
  end

  defp setup_test_bot(_context) do
    config = [set_webhook: false, host: "host.com"]
    bots = [{Test.Bot, [token: tg_token(), max_bot_concurrency: 1]}]
    start_supervised!({Instex.Webhook, config: config, bots: bots})

    :ok
  end
end
