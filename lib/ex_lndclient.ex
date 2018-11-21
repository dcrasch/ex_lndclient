defmodule ExLndclient do
  @moduledoc """
  Usage exlncli --
  """

  @default_macaroonpath "macaroon.txt"
  @default_rpcserver    "127.0.0.1:10009"
  @default_tlscertpath  "tls.cert"

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    options = %{ :macaroonpath => @default_macaroonpath,
                 :rpcserver    => @default_rpcserver,
                 :tlscertpath  => @default_tlscertpath}
    cmd_opts = OptionParser.parse(
      argv,
      switches: [
        help: :boolean,
        macaroonpath: :string,
        rpcserver: :string,
        tlscertpath: :string],
      aliases: [h: :help]
    )
    case cmd_opts do
      { [help: :true], _, _} -> :help
      { opts, args, [] } -> { Enum.into(opts, options), args }
      _ -> :help
    end
  end

  def process(:help) do
    IO.inspect @moduledoc
    System.halt(0)
  end

  def process({options, args}) do
    ca_path = Path.expand(options[:tlscertpath])
    cred = GRPC.Credential.new(ssl: [
          cacertfile: ca_path])
    {:ok, channel} = GRPC.Stub.connect(options[:rpcserver], cred: cred)
    macaroon = Path.expand(options[:macaroonpath])
    |> File.read!
    |> String.trim
    metadata = %{"macaroon" => macaroon }

    request = Lnrpc.GetInfoRequest.new()
    { :ok, reply } = channel
    |> Lnrpc.Lightning.Stub.get_info(request, metadata: metadata)

    IO.inspect reply
  end
end
