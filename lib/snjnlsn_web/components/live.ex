defmodule SnjnlsnWeb.Live do
  use Phoenix.LiveView
  alias SnjnlsnWeb.Modal
  alias SnjnlsnWeb.Button
  alias SnjnlsnWeb.AOTY
  require IEx

  def mount(_, _, socket) do
    {:ok, socket}
  end

  # property :albums,  [
  #   "https://via.placeholder.com/420",
  #   "https://via.placeholder.com/420",
  #   "https://via.placeholder.com/420",
  #   "https://via.placeholder.com/420"
  # ]

  # def render(assigns) do
  #   # IEx.pry
  #   ~H"""
  #   <Modal id="modal">
  #   Haha Modal!
  #   </Modal>
  #   <AOTY id="idk" album_images={{[
  #     "http://placekitten.com/g/480/480",
  #     "http://placekitten.com/g/480/480",
  #     "http://placekitten.com/g/480/480",
  #     "http://placekitten.com/g/480/480"
  #   ]}} />
  #   <Button click="show">
  #     Modal!
  #   </Button>
  #   """
  # end

  def render(assigns) do
    ~L"""
    <div></div>
    """
  end

  def handle_event("show", _, socket) do
    send_update(Modal, id: "modal", show: true)
    {:noreply, socket}
  end
end

# %Plug.Conn{adapter: {Plug.Cowboy.Conn, :...}, assigns: %{}, body_params: %{}, cookies: %{"_snjnlsn_key" => "SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYYnNyXzc5bThGSTViVFdoNUJCNHNESXA0bQAAAA1zcG90aWZ5X3Rva2VubQAAAMxCUUJPTnRDNWRfRG5CdVQ1S0pQNVhHVl9VMDh1TF9YM2JKLUs1a1VXWS1GdmNQakJrZUdRQnhlNGdpQmVFLUwwYlQ1OFZKMTRtb2w4NXZHbnhvTHI3ZEE3NHVrWjB5N3BPdTJ3T3lsNVlyTDYyZFE1S2Vod3lFajB6R0FfVVhNeVNTM1RkZGJQX2U4em9UM0VSSVZ0a0oyRnlaNUlJXzU3aDZxenVlWWQ2S1BteVdOUHN2UVhTZ2ppcHdPQWZFZUhhX0VpTGdpQ2M0c2E.g6km4z8qG8sNkplStmN6wyG-MVR1cvi_64yAgSDEPz4", "_live_deck_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYZWE4WWhVVVdGT1hVYXJ5VDB5VEtBRk1f.B29CvLT1OdNN7TPuAw_4v_XewPTTQMFGZOsq5BsIQqg"}, halted: false, host: "localhost", method: "GET", owner: #PID<0.546.0>, params: %{}, path_info: ["playlists"], path_params: %{}, port: 4000, private: %{SnjnlsnWeb.Router => {[], %{}}, :phoenix_endpoint => SnjnlsnWeb.Endpoint, :phoenix_flash => %{}, :phoenix_format => "html", :phoenix_live_view => [layout: {SnjnlsnWeb.LayoutView, :app}, router: SnjnlsnWeb.Router], :phoenix_router => SnjnlsnWeb.Router, :plug_session => %{"_csrf_token" => "bsr_79m8FI5bTWh5BB4sDIp4", "spotify_token" => "BQBONtC5d_DnBuT5KJP5XGV_U08uL_X3bJ-K5kUWY-FvcPjBkeGQBxe4giBeE-L0bT58VJ14mol85vGnxoLr7dA74ukZ0y7pOu2wOyl5YrL62dQ5KehwyEj0zGA_UXMySS3TddbP_e8zoT3ERIVtkJ2FyZ5II_57h6qzueYd6KPmyWNPsvQXSgjipwOAfEeHa_EiLgiCc4sa"}, :plug_session_fetch => :done}, query_params: %{}, query_string: "", remote_ip: {127, 0, 0, 1}, req_cookies: %{"_snjnlsn_key" => "SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYYnNyXzc5bThGSTViVFdoNUJCNHNESXA0bQAAAA1zcG90aWZ5X3Rva2VubQAAAMxCUUJPTnRDNWRfRG5CdVQ1S0pQNVhHVl9VMDh1TF9YM2JKLUs1a1VXWS1GdmNQakJrZUdRQnhlNGdpQmVFLUwwYlQ1OFZKMTRtb2w4NXZHbnhvTHI3ZEE3NHVrWjB5N3BPdTJ3T3lsNVlyTDYyZFE1S2Vod3lFajB6R0FfVVhNeVNTM1RkZGJQX2U4em9UM0VSSVZ0a0oyRnlaNUlJXzU3aDZxenVlWWQ2S1BteVdOUHN2UVhTZ2ppcHdPQWZFZUhhX0VpTGdpQ2M0c2E.g6km4z8qG8sNkplStmN6wyG-MVR1cvi_64yAgSDEPz4", "_live_deck_key" => "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYZWE4WWhVVVdGT1hVYXJ5VDB5VEtBRk1f.B29CvLT1OdNN7TPuAw_4v_XewPTTQMFGZOsq5BsIQqg"}, req_headers: [{"accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3"}, {"accept-encoding", "gzip, deflate, br"}, {"accept-language", "en-US,en;q=0.9"}, {"connection", "keep-alive"}, {"cookie", "_live_deck_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYZWE4WWhVVVdGT1hVYXJ5VDB5VEtBRk1f.B29CvLT1OdNN7TPuAw_4v_XewPTTQMFGZOsq5BsIQqg; _snjnlsn_key=SFMyNTY.g3QAAAACbQAAAAtfY3NyZl90b2tlbm0AAAAYYnNyXzc5bThGSTViVFdoNUJCNHNESXA0bQAAAA1zcG90aWZ5X3Rva2VubQAAAMxCUUJPTnRDNWRfRG5CdVQ1S0pQNVhHVl9VMDh1TF9YM2JKLUs1a1VXWS1GdmNQakJrZUdRQnhlNGdpQmVFLUwwYlQ1OFZKMTRtb2w4NXZHbnhvTHI3ZEE3NHVrWjB5N3BPdTJ3T3lsNVlyTDYyZFE1S2Vod3lFajB6R0FfVVhNeVNTM1RkZGJQX2U4em9UM0VSSVZ0a0oyRnlaNUlJXzU3aDZxenVlWWQ2S1BteVdOUHN2UVhTZ2ppcHdPQWZFZUhhX0VpTGdpQ2M0c2E.g6km4z8qG8sNkplStmN6wyG-MVR1cvi_64yAgSDEPz4"}, {"host", "localhost:4000"}, {"referer", "http://localhost:4000/"}, {"sec-fetch-mode", "navigate"}, {"sec-fetch-site", "same-origin"}, {"sec-fetch-user", "?1"}, {"upgrade-insecure-requests", "1"}, {"user-agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36"}], request_path: "/playlists", resp_body: nil, resp_cookies: %{}, resp_headers: [{"cache-control", "max-age=0, private, must-revalidate"}, {"x-request-id", "FfP8QpkMXzAjrEsAAAAk"}, {"x-frame-options", "SAMEORIGIN"}, {"x-xss-protection", "1; mode=block"}, {"x-content-type-options", "nosniff"}, {"x-download-options", "noopen"}, {"x-permitted-cross-domain-policies", "none"}, {"cross-origin-window-policy", "deny"}], scheme: :http, script_name: [], secret_key_base: :..., state: :unset, status: nil}
