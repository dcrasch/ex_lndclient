defmodule ExLndclient do
  @moduledoc """
  Usage exlncli --
  """

  @default_macaroonpath "macaroon.txt"
  @default_rpcserver "127.0.0.1:10009"
  @default_tlscertpath "tls.cert"

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    options = %{
      :macaroonpath => @default_macaroonpath,
      :rpcserver => @default_rpcserver,
      :tlscertpath => @default_tlscertpath
    }

    cmd_opts =
      OptionParser.parse(
        argv,
        switches: [
          help: :boolean,
          macaroonpath: :string,
          rpcserver: :string,
          tlscertpath: :string
        ],
        aliases: [h: :help]
      )

    case cmd_opts do
      {[help: true], _, _} -> :help
      {opts, args, []} -> {Enum.into(opts, options), args}
      _ -> :help
    end
  end

  def process(:help) do
    IO.inspect(@moduledoc)
    System.halt(0)
  end

  def process({options, args}) do
    ca_path = Path.expand(options[:tlscertpath])
    cred = GRPC.Credential.new(ssl: [cacertfile: ca_path])
    {:ok, channel} = GRPC.Stub.connect(options[:rpcserver], cred: cred)

    macaroon =
      Path.expand(options[:macaroonpath])
      |> File.read!()
      |> String.trim()

    metadata = %{"macaroon" => macaroon}
    case args do
      ["GetInfo"] -> get_info(channel, metadata)
      ["ListChannels"] -> list_channels(channel, metadata)
      ["ListInvoices"] -> list_invoices(channel, metadata)
      ["SubscribeInvoices"] -> subscribe_invoices(channel, metadata)
    end
  end

  def get_info(channel, metadata) do
    request = Lnrpc.GetInfoRequest.new()
    {:ok, reply} =
      channel
      |> Lnrpc.Lightning.Stub.get_info(request, metadata: metadata)
    IO.inspect(reply)
  end

  def list_channels(channel, metadata) do
    request = Lnrpc.ListChannelsRequest.new()
    {:ok, reply} =
      channel
      |> Lnrpc.Lightning.Stub.list_channels(request, metadata: metadata)
    IO.inspect(reply)
  end

  def lookup_invoices(channel, metadata) do
    payment_hash = <<0,1,2,3>> ## TODO
    request = Lnrpc.PaymentHash.new(r_hash: payment_hash)
    {:ok, reply} =
      channel
      |> Lnrpc.Lightning.Stub.lookup_invoice(request, metadata: metadata)
    IO.inspect(reply)
  end

  def list_invoices(channel, metadata) do
    request = Lnrpc.ListInvoiceRequest.new()
    {:ok, reply} =
      channel
      |> Lnrpc.Lightning.Stub.list_invoices(request, metadata: metadata)
    IO.inspect(reply)
  end

  def add_invoice(channel, metadata) do
    value = 0
    memo = "TODO"
    request = Lnrpc.Invoice.new(value: value, memo: memo)
    {:ok, reply} =
      channel
      |> Lnrpc.Lightning.Stub.add_invoice(request, metadata: metadata)
    IO.inspect(reply)
  end

  def subscribe_invoices(channel, metadata) do
    request = Lnrpc.InvoiceSubscription.new(add_index: 0, settle_index: 0)

    {:ok, stream} =
      channel |> Lnrpc.Lightning.Stub.subscribe_invoices(request, metadata: metadata)

    Enum.each(stream, fn {:ok, invoice} ->
      IO.inspect(invoice)
    end)
  end


end
