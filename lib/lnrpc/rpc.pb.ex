defmodule Lnrpc.GenSeedRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          aezeed_passphrase: String.t(),
          seed_entropy: String.t()
        }
  defstruct [:aezeed_passphrase, :seed_entropy]

  field :aezeed_passphrase, 1, type: :bytes
  field :seed_entropy, 2, type: :bytes
end

defmodule Lnrpc.GenSeedResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cipher_seed_mnemonic: [String.t()],
          enciphered_seed: String.t()
        }
  defstruct [:cipher_seed_mnemonic, :enciphered_seed]

  field :cipher_seed_mnemonic, 1, repeated: true, type: :string
  field :enciphered_seed, 2, type: :bytes
end

defmodule Lnrpc.InitWalletRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          wallet_password: String.t(),
          cipher_seed_mnemonic: [String.t()],
          aezeed_passphrase: String.t(),
          recovery_window: integer
        }
  defstruct [:wallet_password, :cipher_seed_mnemonic, :aezeed_passphrase, :recovery_window]

  field :wallet_password, 1, type: :bytes
  field :cipher_seed_mnemonic, 2, repeated: true, type: :string
  field :aezeed_passphrase, 3, type: :bytes
  field :recovery_window, 4, type: :int32
end

defmodule Lnrpc.InitWalletResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.UnlockWalletRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          wallet_password: String.t(),
          recovery_window: integer
        }
  defstruct [:wallet_password, :recovery_window]

  field :wallet_password, 1, type: :bytes
  field :recovery_window, 2, type: :int32
end

defmodule Lnrpc.UnlockWalletResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.ChangePasswordRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          current_password: String.t(),
          new_password: String.t()
        }
  defstruct [:current_password, :new_password]

  field :current_password, 1, type: :bytes
  field :new_password, 2, type: :bytes
end

defmodule Lnrpc.ChangePasswordResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.Transaction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx_hash: String.t(),
          amount: integer,
          num_confirmations: integer,
          block_hash: String.t(),
          block_height: integer,
          time_stamp: integer,
          total_fees: integer,
          dest_addresses: [String.t()]
        }
  defstruct [
    :tx_hash,
    :amount,
    :num_confirmations,
    :block_hash,
    :block_height,
    :time_stamp,
    :total_fees,
    :dest_addresses
  ]

  field :tx_hash, 1, type: :string
  field :amount, 2, type: :int64
  field :num_confirmations, 3, type: :int32
  field :block_hash, 4, type: :string
  field :block_height, 5, type: :int32
  field :time_stamp, 6, type: :int64
  field :total_fees, 7, type: :int64
  field :dest_addresses, 8, repeated: true, type: :string
end

defmodule Lnrpc.GetTransactionsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.TransactionDetails do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transactions: [Lnrpc.Transaction.t()]
        }
  defstruct [:transactions]

  field :transactions, 1, repeated: true, type: Lnrpc.Transaction
end

defmodule Lnrpc.FeeLimit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          limit: {atom, any}
        }
  defstruct [:limit]

  oneof :limit, 0
  field :fixed, 1, type: :int64, oneof: 0
  field :percent, 2, type: :int64, oneof: 0
end

defmodule Lnrpc.SendRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          dest: String.t(),
          dest_string: String.t(),
          amt: integer,
          payment_hash: String.t(),
          payment_hash_string: String.t(),
          payment_request: String.t(),
          final_cltv_delta: integer,
          fee_limit: Lnrpc.FeeLimit.t()
        }
  defstruct [
    :dest,
    :dest_string,
    :amt,
    :payment_hash,
    :payment_hash_string,
    :payment_request,
    :final_cltv_delta,
    :fee_limit
  ]

  field :dest, 1, type: :bytes
  field :dest_string, 2, type: :string
  field :amt, 3, type: :int64
  field :payment_hash, 4, type: :bytes
  field :payment_hash_string, 5, type: :string
  field :payment_request, 6, type: :string
  field :final_cltv_delta, 7, type: :int32
  field :fee_limit, 8, type: Lnrpc.FeeLimit
end

defmodule Lnrpc.SendResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payment_error: String.t(),
          payment_preimage: String.t(),
          payment_route: Lnrpc.Route.t()
        }
  defstruct [:payment_error, :payment_preimage, :payment_route]

  field :payment_error, 1, type: :string
  field :payment_preimage, 2, type: :bytes
  field :payment_route, 3, type: Lnrpc.Route
end

defmodule Lnrpc.SendToRouteRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payment_hash: String.t(),
          payment_hash_string: String.t(),
          routes: [Lnrpc.Route.t()]
        }
  defstruct [:payment_hash, :payment_hash_string, :routes]

  field :payment_hash, 1, type: :bytes
  field :payment_hash_string, 2, type: :string
  field :routes, 3, repeated: true, type: Lnrpc.Route
end

defmodule Lnrpc.ChannelPoint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          funding_txid: {atom, any},
          output_index: non_neg_integer
        }
  defstruct [:funding_txid, :output_index]

  oneof :funding_txid, 0
  field :funding_txid_bytes, 1, type: :bytes, oneof: 0
  field :funding_txid_str, 2, type: :string, oneof: 0
  field :output_index, 3, type: :uint32
end

defmodule Lnrpc.LightningAddress do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkey: String.t(),
          host: String.t()
        }
  defstruct [:pubkey, :host]

  field :pubkey, 1, type: :string
  field :host, 2, type: :string
end

defmodule Lnrpc.SendManyRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          AddrToAmount: %{String.t() => integer},
          target_conf: integer,
          sat_per_byte: integer
        }
  defstruct [:AddrToAmount, :target_conf, :sat_per_byte]

  field :AddrToAmount, 1, repeated: true, type: Lnrpc.SendManyRequest.AddrToAmountEntry, map: true
  field :target_conf, 3, type: :int32
  field :sat_per_byte, 5, type: :int64
end

defmodule Lnrpc.SendManyRequest.AddrToAmountEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: integer
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :int64
end

defmodule Lnrpc.SendManyResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          txid: String.t()
        }
  defstruct [:txid]

  field :txid, 1, type: :string
end

defmodule Lnrpc.SendCoinsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          addr: String.t(),
          amount: integer,
          target_conf: integer,
          sat_per_byte: integer
        }
  defstruct [:addr, :amount, :target_conf, :sat_per_byte]

  field :addr, 1, type: :string
  field :amount, 2, type: :int64
  field :target_conf, 3, type: :int32
  field :sat_per_byte, 5, type: :int64
end

defmodule Lnrpc.SendCoinsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          txid: String.t()
        }
  defstruct [:txid]

  field :txid, 1, type: :string
end

defmodule Lnrpc.NewAddressRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: integer
        }
  defstruct [:type]

  field :type, 1, type: Lnrpc.NewAddressRequest.AddressType, enum: true
end

defmodule Lnrpc.NewAddressRequest.AddressType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :WITNESS_PUBKEY_HASH, 0
  field :NESTED_PUBKEY_HASH, 1
end

defmodule Lnrpc.NewAddressResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t()
        }
  defstruct [:address]

  field :address, 1, type: :string
end

defmodule Lnrpc.SignMessageRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          msg: String.t()
        }
  defstruct [:msg]

  field :msg, 1, type: :bytes
end

defmodule Lnrpc.SignMessageResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          signature: String.t()
        }
  defstruct [:signature]

  field :signature, 1, type: :string
end

defmodule Lnrpc.VerifyMessageRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          msg: String.t(),
          signature: String.t()
        }
  defstruct [:msg, :signature]

  field :msg, 1, type: :bytes
  field :signature, 2, type: :string
end

defmodule Lnrpc.VerifyMessageResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          valid: boolean,
          pubkey: String.t()
        }
  defstruct [:valid, :pubkey]

  field :valid, 1, type: :bool
  field :pubkey, 2, type: :string
end

defmodule Lnrpc.ConnectPeerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          addr: Lnrpc.LightningAddress.t(),
          perm: boolean
        }
  defstruct [:addr, :perm]

  field :addr, 1, type: Lnrpc.LightningAddress
  field :perm, 2, type: :bool
end

defmodule Lnrpc.ConnectPeerResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.DisconnectPeerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: String.t()
        }
  defstruct [:pub_key]

  field :pub_key, 1, type: :string
end

defmodule Lnrpc.DisconnectPeerResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.HTLC do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          incoming: boolean,
          amount: integer,
          hash_lock: String.t(),
          expiration_height: non_neg_integer
        }
  defstruct [:incoming, :amount, :hash_lock, :expiration_height]

  field :incoming, 1, type: :bool
  field :amount, 2, type: :int64
  field :hash_lock, 3, type: :bytes
  field :expiration_height, 4, type: :uint32
end

defmodule Lnrpc.Channel do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          active: boolean,
          remote_pubkey: String.t(),
          channel_point: String.t(),
          chan_id: non_neg_integer,
          capacity: integer,
          local_balance: integer,
          remote_balance: integer,
          commit_fee: integer,
          commit_weight: integer,
          fee_per_kw: integer,
          unsettled_balance: integer,
          total_satoshis_sent: integer,
          total_satoshis_received: integer,
          num_updates: non_neg_integer,
          pending_htlcs: [Lnrpc.HTLC.t()],
          csv_delay: non_neg_integer,
          private: boolean
        }
  defstruct [
    :active,
    :remote_pubkey,
    :channel_point,
    :chan_id,
    :capacity,
    :local_balance,
    :remote_balance,
    :commit_fee,
    :commit_weight,
    :fee_per_kw,
    :unsettled_balance,
    :total_satoshis_sent,
    :total_satoshis_received,
    :num_updates,
    :pending_htlcs,
    :csv_delay,
    :private
  ]

  field :active, 1, type: :bool
  field :remote_pubkey, 2, type: :string
  field :channel_point, 3, type: :string
  field :chan_id, 4, type: :uint64
  field :capacity, 5, type: :int64
  field :local_balance, 6, type: :int64
  field :remote_balance, 7, type: :int64
  field :commit_fee, 8, type: :int64
  field :commit_weight, 9, type: :int64
  field :fee_per_kw, 10, type: :int64
  field :unsettled_balance, 11, type: :int64
  field :total_satoshis_sent, 12, type: :int64
  field :total_satoshis_received, 13, type: :int64
  field :num_updates, 14, type: :uint64
  field :pending_htlcs, 15, repeated: true, type: Lnrpc.HTLC
  field :csv_delay, 16, type: :uint32
  field :private, 17, type: :bool
end

defmodule Lnrpc.ListChannelsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          active_only: boolean,
          inactive_only: boolean,
          public_only: boolean,
          private_only: boolean
        }
  defstruct [:active_only, :inactive_only, :public_only, :private_only]

  field :active_only, 1, type: :bool
  field :inactive_only, 2, type: :bool
  field :public_only, 3, type: :bool
  field :private_only, 4, type: :bool
end

defmodule Lnrpc.ListChannelsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channels: [Lnrpc.Channel.t()]
        }
  defstruct [:channels]

  field :channels, 11, repeated: true, type: Lnrpc.Channel
end

defmodule Lnrpc.ChannelCloseSummary do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel_point: String.t(),
          chan_id: non_neg_integer,
          chain_hash: String.t(),
          closing_tx_hash: String.t(),
          remote_pubkey: String.t(),
          capacity: integer,
          close_height: non_neg_integer,
          settled_balance: integer,
          time_locked_balance: integer,
          close_type: integer
        }
  defstruct [
    :channel_point,
    :chan_id,
    :chain_hash,
    :closing_tx_hash,
    :remote_pubkey,
    :capacity,
    :close_height,
    :settled_balance,
    :time_locked_balance,
    :close_type
  ]

  field :channel_point, 1, type: :string
  field :chan_id, 2, type: :uint64
  field :chain_hash, 3, type: :string
  field :closing_tx_hash, 4, type: :string
  field :remote_pubkey, 5, type: :string
  field :capacity, 6, type: :int64
  field :close_height, 7, type: :uint32
  field :settled_balance, 8, type: :int64
  field :time_locked_balance, 9, type: :int64
  field :close_type, 10, type: Lnrpc.ChannelCloseSummary.ClosureType, enum: true
end

defmodule Lnrpc.ChannelCloseSummary.ClosureType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  field :COOPERATIVE_CLOSE, 0
  field :LOCAL_FORCE_CLOSE, 1
  field :REMOTE_FORCE_CLOSE, 2
  field :BREACH_CLOSE, 3
  field :FUNDING_CANCELED, 4
  field :ABANDONED, 5
end

defmodule Lnrpc.ClosedChannelsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cooperative: boolean,
          local_force: boolean,
          remote_force: boolean,
          breach: boolean,
          funding_canceled: boolean,
          abandoned: boolean
        }
  defstruct [:cooperative, :local_force, :remote_force, :breach, :funding_canceled, :abandoned]

  field :cooperative, 1, type: :bool
  field :local_force, 2, type: :bool
  field :remote_force, 3, type: :bool
  field :breach, 4, type: :bool
  field :funding_canceled, 5, type: :bool
  field :abandoned, 6, type: :bool
end

defmodule Lnrpc.ClosedChannelsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channels: [Lnrpc.ChannelCloseSummary.t()]
        }
  defstruct [:channels]

  field :channels, 1, repeated: true, type: Lnrpc.ChannelCloseSummary
end

defmodule Lnrpc.Peer do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: String.t(),
          address: String.t(),
          bytes_sent: non_neg_integer,
          bytes_recv: non_neg_integer,
          sat_sent: integer,
          sat_recv: integer,
          inbound: boolean,
          ping_time: integer
        }
  defstruct [
    :pub_key,
    :address,
    :bytes_sent,
    :bytes_recv,
    :sat_sent,
    :sat_recv,
    :inbound,
    :ping_time
  ]

  field :pub_key, 1, type: :string
  field :address, 3, type: :string
  field :bytes_sent, 4, type: :uint64
  field :bytes_recv, 5, type: :uint64
  field :sat_sent, 6, type: :int64
  field :sat_recv, 7, type: :int64
  field :inbound, 8, type: :bool
  field :ping_time, 9, type: :int64
end

defmodule Lnrpc.ListPeersRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.ListPeersResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          peers: [Lnrpc.Peer.t()]
        }
  defstruct [:peers]

  field :peers, 1, repeated: true, type: Lnrpc.Peer
end

defmodule Lnrpc.GetInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.GetInfoResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          identity_pubkey: String.t(),
          alias: String.t(),
          num_pending_channels: non_neg_integer,
          num_active_channels: non_neg_integer,
          num_peers: non_neg_integer,
          block_height: non_neg_integer,
          block_hash: String.t(),
          synced_to_chain: boolean,
          testnet: boolean,
          chains: [String.t()],
          uris: [String.t()],
          best_header_timestamp: integer,
          version: String.t()
        }
  defstruct [
    :identity_pubkey,
    :alias,
    :num_pending_channels,
    :num_active_channels,
    :num_peers,
    :block_height,
    :block_hash,
    :synced_to_chain,
    :testnet,
    :chains,
    :uris,
    :best_header_timestamp,
    :version
  ]

  field :identity_pubkey, 1, type: :string
  field :alias, 2, type: :string
  field :num_pending_channels, 3, type: :uint32
  field :num_active_channels, 4, type: :uint32
  field :num_peers, 5, type: :uint32
  field :block_height, 6, type: :uint32
  field :block_hash, 8, type: :string
  field :synced_to_chain, 9, type: :bool
  field :testnet, 10, type: :bool
  field :chains, 11, repeated: true, type: :string
  field :uris, 12, repeated: true, type: :string
  field :best_header_timestamp, 13, type: :int64
  field :version, 14, type: :string
end

defmodule Lnrpc.ConfirmationUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block_sha: String.t(),
          block_height: integer,
          num_confs_left: non_neg_integer
        }
  defstruct [:block_sha, :block_height, :num_confs_left]

  field :block_sha, 1, type: :bytes
  field :block_height, 2, type: :int32
  field :num_confs_left, 3, type: :uint32
end

defmodule Lnrpc.ChannelOpenUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel_point: Lnrpc.ChannelPoint.t()
        }
  defstruct [:channel_point]

  field :channel_point, 1, type: Lnrpc.ChannelPoint
end

defmodule Lnrpc.ChannelCloseUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          closing_txid: String.t(),
          success: boolean
        }
  defstruct [:closing_txid, :success]

  field :closing_txid, 1, type: :bytes
  field :success, 2, type: :bool
end

defmodule Lnrpc.CloseChannelRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel_point: Lnrpc.ChannelPoint.t(),
          force: boolean,
          target_conf: integer,
          sat_per_byte: integer
        }
  defstruct [:channel_point, :force, :target_conf, :sat_per_byte]

  field :channel_point, 1, type: Lnrpc.ChannelPoint
  field :force, 2, type: :bool
  field :target_conf, 3, type: :int32
  field :sat_per_byte, 4, type: :int64
end

defmodule Lnrpc.CloseStatusUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          update: {atom, any}
        }
  defstruct [:update]

  oneof :update, 0
  field :close_pending, 1, type: Lnrpc.PendingUpdate, oneof: 0
  field :confirmation, 2, type: Lnrpc.ConfirmationUpdate, oneof: 0
  field :chan_close, 3, type: Lnrpc.ChannelCloseUpdate, oneof: 0
end

defmodule Lnrpc.PendingUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          txid: String.t(),
          output_index: non_neg_integer
        }
  defstruct [:txid, :output_index]

  field :txid, 1, type: :bytes
  field :output_index, 2, type: :uint32
end

defmodule Lnrpc.OpenChannelRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          node_pubkey: String.t(),
          node_pubkey_string: String.t(),
          local_funding_amount: integer,
          push_sat: integer,
          target_conf: integer,
          sat_per_byte: integer,
          private: boolean,
          min_htlc_msat: integer,
          remote_csv_delay: non_neg_integer,
          min_confs: integer,
          spend_unconfirmed: boolean
        }
  defstruct [
    :node_pubkey,
    :node_pubkey_string,
    :local_funding_amount,
    :push_sat,
    :target_conf,
    :sat_per_byte,
    :private,
    :min_htlc_msat,
    :remote_csv_delay,
    :min_confs,
    :spend_unconfirmed
  ]

  field :node_pubkey, 2, type: :bytes
  field :node_pubkey_string, 3, type: :string
  field :local_funding_amount, 4, type: :int64
  field :push_sat, 5, type: :int64
  field :target_conf, 6, type: :int32
  field :sat_per_byte, 7, type: :int64
  field :private, 8, type: :bool
  field :min_htlc_msat, 9, type: :int64
  field :remote_csv_delay, 10, type: :uint32
  field :min_confs, 11, type: :int32
  field :spend_unconfirmed, 12, type: :bool
end

defmodule Lnrpc.OpenStatusUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          update: {atom, any}
        }
  defstruct [:update]

  oneof :update, 0
  field :chan_pending, 1, type: Lnrpc.PendingUpdate, oneof: 0
  field :confirmation, 2, type: Lnrpc.ConfirmationUpdate, oneof: 0
  field :chan_open, 3, type: Lnrpc.ChannelOpenUpdate, oneof: 0
end

defmodule Lnrpc.PendingHTLC do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          incoming: boolean,
          amount: integer,
          outpoint: String.t(),
          maturity_height: non_neg_integer,
          blocks_til_maturity: integer,
          stage: non_neg_integer
        }
  defstruct [:incoming, :amount, :outpoint, :maturity_height, :blocks_til_maturity, :stage]

  field :incoming, 1, type: :bool
  field :amount, 2, type: :int64
  field :outpoint, 3, type: :string
  field :maturity_height, 4, type: :uint32
  field :blocks_til_maturity, 5, type: :int32
  field :stage, 6, type: :uint32
end

defmodule Lnrpc.PendingChannelsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.PendingChannelsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total_limbo_balance: integer,
          pending_open_channels: [Lnrpc.PendingChannelsResponse.PendingOpenChannel.t()],
          pending_closing_channels: [Lnrpc.PendingChannelsResponse.ClosedChannel.t()],
          pending_force_closing_channels: [Lnrpc.PendingChannelsResponse.ForceClosedChannel.t()],
          waiting_close_channels: [Lnrpc.PendingChannelsResponse.WaitingCloseChannel.t()]
        }
  defstruct [
    :total_limbo_balance,
    :pending_open_channels,
    :pending_closing_channels,
    :pending_force_closing_channels,
    :waiting_close_channels
  ]

  field :total_limbo_balance, 1, type: :int64

  field :pending_open_channels, 2,
    repeated: true,
    type: Lnrpc.PendingChannelsResponse.PendingOpenChannel

  field :pending_closing_channels, 3,
    repeated: true,
    type: Lnrpc.PendingChannelsResponse.ClosedChannel

  field :pending_force_closing_channels, 4,
    repeated: true,
    type: Lnrpc.PendingChannelsResponse.ForceClosedChannel

  field :waiting_close_channels, 5,
    repeated: true,
    type: Lnrpc.PendingChannelsResponse.WaitingCloseChannel
end

defmodule Lnrpc.PendingChannelsResponse.PendingChannel do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          remote_node_pub: String.t(),
          channel_point: String.t(),
          capacity: integer,
          local_balance: integer,
          remote_balance: integer
        }
  defstruct [:remote_node_pub, :channel_point, :capacity, :local_balance, :remote_balance]

  field :remote_node_pub, 1, type: :string
  field :channel_point, 2, type: :string
  field :capacity, 3, type: :int64
  field :local_balance, 4, type: :int64
  field :remote_balance, 5, type: :int64
end

defmodule Lnrpc.PendingChannelsResponse.PendingOpenChannel do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel: Lnrpc.PendingChannelsResponse.PendingChannel.t(),
          confirmation_height: non_neg_integer,
          commit_fee: integer,
          commit_weight: integer,
          fee_per_kw: integer
        }
  defstruct [:channel, :confirmation_height, :commit_fee, :commit_weight, :fee_per_kw]

  field :channel, 1, type: Lnrpc.PendingChannelsResponse.PendingChannel
  field :confirmation_height, 2, type: :uint32
  field :commit_fee, 4, type: :int64
  field :commit_weight, 5, type: :int64
  field :fee_per_kw, 6, type: :int64
end

defmodule Lnrpc.PendingChannelsResponse.WaitingCloseChannel do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel: Lnrpc.PendingChannelsResponse.PendingChannel.t(),
          limbo_balance: integer
        }
  defstruct [:channel, :limbo_balance]

  field :channel, 1, type: Lnrpc.PendingChannelsResponse.PendingChannel
  field :limbo_balance, 2, type: :int64
end

defmodule Lnrpc.PendingChannelsResponse.ClosedChannel do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel: Lnrpc.PendingChannelsResponse.PendingChannel.t(),
          closing_txid: String.t()
        }
  defstruct [:channel, :closing_txid]

  field :channel, 1, type: Lnrpc.PendingChannelsResponse.PendingChannel
  field :closing_txid, 2, type: :string
end

defmodule Lnrpc.PendingChannelsResponse.ForceClosedChannel do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel: Lnrpc.PendingChannelsResponse.PendingChannel.t(),
          closing_txid: String.t(),
          limbo_balance: integer,
          maturity_height: non_neg_integer,
          blocks_til_maturity: integer,
          recovered_balance: integer,
          pending_htlcs: [Lnrpc.PendingHTLC.t()]
        }
  defstruct [
    :channel,
    :closing_txid,
    :limbo_balance,
    :maturity_height,
    :blocks_til_maturity,
    :recovered_balance,
    :pending_htlcs
  ]

  field :channel, 1, type: Lnrpc.PendingChannelsResponse.PendingChannel
  field :closing_txid, 2, type: :string
  field :limbo_balance, 3, type: :int64
  field :maturity_height, 4, type: :uint32
  field :blocks_til_maturity, 5, type: :int32
  field :recovered_balance, 6, type: :int64
  field :pending_htlcs, 8, repeated: true, type: Lnrpc.PendingHTLC
end

defmodule Lnrpc.WalletBalanceRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.WalletBalanceResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total_balance: integer,
          confirmed_balance: integer,
          unconfirmed_balance: integer
        }
  defstruct [:total_balance, :confirmed_balance, :unconfirmed_balance]

  field :total_balance, 1, type: :int64
  field :confirmed_balance, 2, type: :int64
  field :unconfirmed_balance, 3, type: :int64
end

defmodule Lnrpc.ChannelBalanceRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.ChannelBalanceResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          balance: integer,
          pending_open_balance: integer
        }
  defstruct [:balance, :pending_open_balance]

  field :balance, 1, type: :int64
  field :pending_open_balance, 2, type: :int64
end

defmodule Lnrpc.QueryRoutesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: String.t(),
          amt: integer,
          num_routes: integer,
          final_cltv_delta: integer,
          fee_limit: Lnrpc.FeeLimit.t()
        }
  defstruct [:pub_key, :amt, :num_routes, :final_cltv_delta, :fee_limit]

  field :pub_key, 1, type: :string
  field :amt, 2, type: :int64
  field :num_routes, 3, type: :int32
  field :final_cltv_delta, 4, type: :int32
  field :fee_limit, 5, type: Lnrpc.FeeLimit
end

defmodule Lnrpc.QueryRoutesResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          routes: [Lnrpc.Route.t()]
        }
  defstruct [:routes]

  field :routes, 1, repeated: true, type: Lnrpc.Route
end

defmodule Lnrpc.Hop do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chan_id: non_neg_integer,
          chan_capacity: integer,
          amt_to_forward: integer,
          fee: integer,
          expiry: non_neg_integer,
          amt_to_forward_msat: integer,
          fee_msat: integer
        }
  defstruct [
    :chan_id,
    :chan_capacity,
    :amt_to_forward,
    :fee,
    :expiry,
    :amt_to_forward_msat,
    :fee_msat
  ]

  field :chan_id, 1, type: :uint64
  field :chan_capacity, 2, type: :int64
  field :amt_to_forward, 3, type: :int64, deprecated: true
  field :fee, 4, type: :int64, deprecated: true
  field :expiry, 5, type: :uint32
  field :amt_to_forward_msat, 6, type: :int64
  field :fee_msat, 7, type: :int64
end

defmodule Lnrpc.Route do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total_time_lock: non_neg_integer,
          total_fees: integer,
          total_amt: integer,
          hops: [Lnrpc.Hop.t()],
          total_fees_msat: integer,
          total_amt_msat: integer
        }
  defstruct [:total_time_lock, :total_fees, :total_amt, :hops, :total_fees_msat, :total_amt_msat]

  field :total_time_lock, 1, type: :uint32
  field :total_fees, 2, type: :int64, deprecated: true
  field :total_amt, 3, type: :int64, deprecated: true
  field :hops, 4, repeated: true, type: Lnrpc.Hop
  field :total_fees_msat, 5, type: :int64
  field :total_amt_msat, 6, type: :int64
end

defmodule Lnrpc.NodeInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: String.t()
        }
  defstruct [:pub_key]

  field :pub_key, 1, type: :string
end

defmodule Lnrpc.NodeInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          node: Lnrpc.LightningNode.t(),
          num_channels: non_neg_integer,
          total_capacity: integer
        }
  defstruct [:node, :num_channels, :total_capacity]

  field :node, 1, type: Lnrpc.LightningNode
  field :num_channels, 2, type: :uint32
  field :total_capacity, 3, type: :int64
end

defmodule Lnrpc.LightningNode do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          last_update: non_neg_integer,
          pub_key: String.t(),
          alias: String.t(),
          addresses: [Lnrpc.NodeAddress.t()],
          color: String.t()
        }
  defstruct [:last_update, :pub_key, :alias, :addresses, :color]

  field :last_update, 1, type: :uint32
  field :pub_key, 2, type: :string
  field :alias, 3, type: :string
  field :addresses, 4, repeated: true, type: Lnrpc.NodeAddress
  field :color, 5, type: :string
end

defmodule Lnrpc.NodeAddress do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          network: String.t(),
          addr: String.t()
        }
  defstruct [:network, :addr]

  field :network, 1, type: :string
  field :addr, 2, type: :string
end

defmodule Lnrpc.RoutingPolicy do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          time_lock_delta: non_neg_integer,
          min_htlc: integer,
          fee_base_msat: integer,
          fee_rate_milli_msat: integer,
          disabled: boolean
        }
  defstruct [:time_lock_delta, :min_htlc, :fee_base_msat, :fee_rate_milli_msat, :disabled]

  field :time_lock_delta, 1, type: :uint32
  field :min_htlc, 2, type: :int64
  field :fee_base_msat, 3, type: :int64
  field :fee_rate_milli_msat, 4, type: :int64
  field :disabled, 5, type: :bool
end

defmodule Lnrpc.ChannelEdge do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel_id: non_neg_integer,
          chan_point: String.t(),
          last_update: non_neg_integer,
          node1_pub: String.t(),
          node2_pub: String.t(),
          capacity: integer,
          node1_policy: Lnrpc.RoutingPolicy.t(),
          node2_policy: Lnrpc.RoutingPolicy.t()
        }
  defstruct [
    :channel_id,
    :chan_point,
    :last_update,
    :node1_pub,
    :node2_pub,
    :capacity,
    :node1_policy,
    :node2_policy
  ]

  field :channel_id, 1, type: :uint64
  field :chan_point, 2, type: :string
  field :last_update, 3, type: :uint32
  field :node1_pub, 4, type: :string
  field :node2_pub, 5, type: :string
  field :capacity, 6, type: :int64
  field :node1_policy, 7, type: Lnrpc.RoutingPolicy
  field :node2_policy, 8, type: Lnrpc.RoutingPolicy
end

defmodule Lnrpc.ChannelGraphRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          include_unannounced: boolean
        }
  defstruct [:include_unannounced]

  field :include_unannounced, 1, type: :bool
end

defmodule Lnrpc.ChannelGraph do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          nodes: [Lnrpc.LightningNode.t()],
          edges: [Lnrpc.ChannelEdge.t()]
        }
  defstruct [:nodes, :edges]

  field :nodes, 1, repeated: true, type: Lnrpc.LightningNode
  field :edges, 2, repeated: true, type: Lnrpc.ChannelEdge
end

defmodule Lnrpc.ChanInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chan_id: non_neg_integer
        }
  defstruct [:chan_id]

  field :chan_id, 1, type: :uint64
end

defmodule Lnrpc.NetworkInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.NetworkInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          graph_diameter: non_neg_integer,
          avg_out_degree: float,
          max_out_degree: non_neg_integer,
          num_nodes: non_neg_integer,
          num_channels: non_neg_integer,
          total_network_capacity: integer,
          avg_channel_size: float,
          min_channel_size: integer,
          max_channel_size: integer
        }
  defstruct [
    :graph_diameter,
    :avg_out_degree,
    :max_out_degree,
    :num_nodes,
    :num_channels,
    :total_network_capacity,
    :avg_channel_size,
    :min_channel_size,
    :max_channel_size
  ]

  field :graph_diameter, 1, type: :uint32
  field :avg_out_degree, 2, type: :double
  field :max_out_degree, 3, type: :uint32
  field :num_nodes, 4, type: :uint32
  field :num_channels, 5, type: :uint32
  field :total_network_capacity, 6, type: :int64
  field :avg_channel_size, 7, type: :double
  field :min_channel_size, 8, type: :int64
  field :max_channel_size, 9, type: :int64
end

defmodule Lnrpc.StopRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.StopResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.GraphTopologySubscription do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.GraphTopologyUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          node_updates: [Lnrpc.NodeUpdate.t()],
          channel_updates: [Lnrpc.ChannelEdgeUpdate.t()],
          closed_chans: [Lnrpc.ClosedChannelUpdate.t()]
        }
  defstruct [:node_updates, :channel_updates, :closed_chans]

  field :node_updates, 1, repeated: true, type: Lnrpc.NodeUpdate
  field :channel_updates, 2, repeated: true, type: Lnrpc.ChannelEdgeUpdate
  field :closed_chans, 3, repeated: true, type: Lnrpc.ClosedChannelUpdate
end

defmodule Lnrpc.NodeUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          addresses: [String.t()],
          identity_key: String.t(),
          global_features: String.t(),
          alias: String.t()
        }
  defstruct [:addresses, :identity_key, :global_features, :alias]

  field :addresses, 1, repeated: true, type: :string
  field :identity_key, 2, type: :string
  field :global_features, 3, type: :bytes
  field :alias, 4, type: :string
end

defmodule Lnrpc.ChannelEdgeUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chan_id: non_neg_integer,
          chan_point: Lnrpc.ChannelPoint.t(),
          capacity: integer,
          routing_policy: Lnrpc.RoutingPolicy.t(),
          advertising_node: String.t(),
          connecting_node: String.t()
        }
  defstruct [
    :chan_id,
    :chan_point,
    :capacity,
    :routing_policy,
    :advertising_node,
    :connecting_node
  ]

  field :chan_id, 1, type: :uint64
  field :chan_point, 2, type: Lnrpc.ChannelPoint
  field :capacity, 3, type: :int64
  field :routing_policy, 4, type: Lnrpc.RoutingPolicy
  field :advertising_node, 5, type: :string
  field :connecting_node, 6, type: :string
end

defmodule Lnrpc.ClosedChannelUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chan_id: non_neg_integer,
          capacity: integer,
          closed_height: non_neg_integer,
          chan_point: Lnrpc.ChannelPoint.t()
        }
  defstruct [:chan_id, :capacity, :closed_height, :chan_point]

  field :chan_id, 1, type: :uint64
  field :capacity, 2, type: :int64
  field :closed_height, 3, type: :uint32
  field :chan_point, 4, type: Lnrpc.ChannelPoint
end

defmodule Lnrpc.HopHint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          node_id: String.t(),
          chan_id: non_neg_integer,
          fee_base_msat: non_neg_integer,
          fee_proportional_millionths: non_neg_integer,
          cltv_expiry_delta: non_neg_integer
        }
  defstruct [:node_id, :chan_id, :fee_base_msat, :fee_proportional_millionths, :cltv_expiry_delta]

  field :node_id, 1, type: :string
  field :chan_id, 2, type: :uint64
  field :fee_base_msat, 3, type: :uint32
  field :fee_proportional_millionths, 4, type: :uint32
  field :cltv_expiry_delta, 5, type: :uint32
end

defmodule Lnrpc.RouteHint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hop_hints: [Lnrpc.HopHint.t()]
        }
  defstruct [:hop_hints]

  field :hop_hints, 1, repeated: true, type: Lnrpc.HopHint
end

defmodule Lnrpc.Invoice do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          memo: String.t(),
          receipt: String.t(),
          r_preimage: String.t(),
          r_hash: String.t(),
          value: integer,
          settled: boolean,
          creation_date: integer,
          settle_date: integer,
          payment_request: String.t(),
          description_hash: String.t(),
          expiry: integer,
          fallback_addr: String.t(),
          cltv_expiry: non_neg_integer,
          route_hints: [Lnrpc.RouteHint.t()],
          private: boolean,
          add_index: non_neg_integer,
          settle_index: non_neg_integer,
          amt_paid: integer,
          amt_paid_sat: integer,
          amt_paid_msat: integer
        }
  defstruct [
    :memo,
    :receipt,
    :r_preimage,
    :r_hash,
    :value,
    :settled,
    :creation_date,
    :settle_date,
    :payment_request,
    :description_hash,
    :expiry,
    :fallback_addr,
    :cltv_expiry,
    :route_hints,
    :private,
    :add_index,
    :settle_index,
    :amt_paid,
    :amt_paid_sat,
    :amt_paid_msat
  ]

  field :memo, 1, type: :string
  field :receipt, 2, type: :bytes
  field :r_preimage, 3, type: :bytes
  field :r_hash, 4, type: :bytes
  field :value, 5, type: :int64
  field :settled, 6, type: :bool
  field :creation_date, 7, type: :int64
  field :settle_date, 8, type: :int64
  field :payment_request, 9, type: :string
  field :description_hash, 10, type: :bytes
  field :expiry, 11, type: :int64
  field :fallback_addr, 12, type: :string
  field :cltv_expiry, 13, type: :uint64
  field :route_hints, 14, repeated: true, type: Lnrpc.RouteHint
  field :private, 15, type: :bool
  field :add_index, 16, type: :uint64
  field :settle_index, 17, type: :uint64
  field :amt_paid, 18, type: :int64, deprecated: true
  field :amt_paid_sat, 19, type: :int64
  field :amt_paid_msat, 20, type: :int64
end

defmodule Lnrpc.AddInvoiceResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          r_hash: String.t(),
          payment_request: String.t(),
          add_index: non_neg_integer
        }
  defstruct [:r_hash, :payment_request, :add_index]

  field :r_hash, 1, type: :bytes
  field :payment_request, 2, type: :string
  field :add_index, 16, type: :uint64
end

defmodule Lnrpc.PaymentHash do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          r_hash_str: String.t(),
          r_hash: String.t()
        }
  defstruct [:r_hash_str, :r_hash]

  field :r_hash_str, 1, type: :string
  field :r_hash, 2, type: :bytes
end

defmodule Lnrpc.ListInvoiceRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pending_only: boolean,
          index_offset: non_neg_integer,
          num_max_invoices: non_neg_integer,
          reversed: boolean
        }
  defstruct [:pending_only, :index_offset, :num_max_invoices, :reversed]

  field :pending_only, 1, type: :bool
  field :index_offset, 4, type: :uint64
  field :num_max_invoices, 5, type: :uint64
  field :reversed, 6, type: :bool
end

defmodule Lnrpc.ListInvoiceResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          invoices: [Lnrpc.Invoice.t()],
          last_index_offset: non_neg_integer,
          first_index_offset: non_neg_integer
        }
  defstruct [:invoices, :last_index_offset, :first_index_offset]

  field :invoices, 1, repeated: true, type: Lnrpc.Invoice
  field :last_index_offset, 2, type: :uint64
  field :first_index_offset, 3, type: :uint64
end

defmodule Lnrpc.InvoiceSubscription do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          add_index: non_neg_integer,
          settle_index: non_neg_integer
        }
  defstruct [:add_index, :settle_index]

  field :add_index, 1, type: :uint64
  field :settle_index, 2, type: :uint64
end

defmodule Lnrpc.Payment do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payment_hash: String.t(),
          value: integer,
          creation_date: integer,
          path: [String.t()],
          fee: integer,
          payment_preimage: String.t(),
          value_sat: integer,
          value_msat: integer
        }
  defstruct [
    :payment_hash,
    :value,
    :creation_date,
    :path,
    :fee,
    :payment_preimage,
    :value_sat,
    :value_msat
  ]

  field :payment_hash, 1, type: :string
  field :value, 2, type: :int64, deprecated: true
  field :creation_date, 3, type: :int64
  field :path, 4, repeated: true, type: :string
  field :fee, 5, type: :int64
  field :payment_preimage, 6, type: :string
  field :value_sat, 7, type: :int64
  field :value_msat, 8, type: :int64
end

defmodule Lnrpc.ListPaymentsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.ListPaymentsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payments: [Lnrpc.Payment.t()]
        }
  defstruct [:payments]

  field :payments, 1, repeated: true, type: Lnrpc.Payment
end

defmodule Lnrpc.DeleteAllPaymentsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.DeleteAllPaymentsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.AbandonChannelRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel_point: Lnrpc.ChannelPoint.t()
        }
  defstruct [:channel_point]

  field :channel_point, 1, type: Lnrpc.ChannelPoint
end

defmodule Lnrpc.AbandonChannelResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.DebugLevelRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          show: boolean,
          level_spec: String.t()
        }
  defstruct [:show, :level_spec]

  field :show, 1, type: :bool
  field :level_spec, 2, type: :string
end

defmodule Lnrpc.DebugLevelResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sub_systems: String.t()
        }
  defstruct [:sub_systems]

  field :sub_systems, 1, type: :string
end

defmodule Lnrpc.PayReqString do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pay_req: String.t()
        }
  defstruct [:pay_req]

  field :pay_req, 1, type: :string
end

defmodule Lnrpc.PayReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          destination: String.t(),
          payment_hash: String.t(),
          num_satoshis: integer,
          timestamp: integer,
          expiry: integer,
          description: String.t(),
          description_hash: String.t(),
          fallback_addr: String.t(),
          cltv_expiry: integer,
          route_hints: [Lnrpc.RouteHint.t()]
        }
  defstruct [
    :destination,
    :payment_hash,
    :num_satoshis,
    :timestamp,
    :expiry,
    :description,
    :description_hash,
    :fallback_addr,
    :cltv_expiry,
    :route_hints
  ]

  field :destination, 1, type: :string
  field :payment_hash, 2, type: :string
  field :num_satoshis, 3, type: :int64
  field :timestamp, 4, type: :int64
  field :expiry, 5, type: :int64
  field :description, 6, type: :string
  field :description_hash, 7, type: :string
  field :fallback_addr, 8, type: :string
  field :cltv_expiry, 9, type: :int64
  field :route_hints, 10, repeated: true, type: Lnrpc.RouteHint
end

defmodule Lnrpc.FeeReportRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.ChannelFeeReport do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          chan_point: String.t(),
          base_fee_msat: integer,
          fee_per_mil: integer,
          fee_rate: float
        }
  defstruct [:chan_point, :base_fee_msat, :fee_per_mil, :fee_rate]

  field :chan_point, 1, type: :string
  field :base_fee_msat, 2, type: :int64
  field :fee_per_mil, 3, type: :int64
  field :fee_rate, 4, type: :double
end

defmodule Lnrpc.FeeReportResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          channel_fees: [Lnrpc.ChannelFeeReport.t()],
          day_fee_sum: non_neg_integer,
          week_fee_sum: non_neg_integer,
          month_fee_sum: non_neg_integer
        }
  defstruct [:channel_fees, :day_fee_sum, :week_fee_sum, :month_fee_sum]

  field :channel_fees, 1, repeated: true, type: Lnrpc.ChannelFeeReport
  field :day_fee_sum, 2, type: :uint64
  field :week_fee_sum, 3, type: :uint64
  field :month_fee_sum, 4, type: :uint64
end

defmodule Lnrpc.PolicyUpdateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          scope: {atom, any},
          base_fee_msat: integer,
          fee_rate: float,
          time_lock_delta: non_neg_integer
        }
  defstruct [:scope, :base_fee_msat, :fee_rate, :time_lock_delta]

  oneof :scope, 0
  field :global, 1, type: :bool, oneof: 0
  field :chan_point, 2, type: Lnrpc.ChannelPoint, oneof: 0
  field :base_fee_msat, 3, type: :int64
  field :fee_rate, 4, type: :double
  field :time_lock_delta, 5, type: :uint32
end

defmodule Lnrpc.PolicyUpdateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule Lnrpc.ForwardingHistoryRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          start_time: non_neg_integer,
          end_time: non_neg_integer,
          index_offset: non_neg_integer,
          num_max_events: non_neg_integer
        }
  defstruct [:start_time, :end_time, :index_offset, :num_max_events]

  field :start_time, 1, type: :uint64
  field :end_time, 2, type: :uint64
  field :index_offset, 3, type: :uint32
  field :num_max_events, 4, type: :uint32
end

defmodule Lnrpc.ForwardingEvent do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          timestamp: non_neg_integer,
          chan_id_in: non_neg_integer,
          chan_id_out: non_neg_integer,
          amt_in: non_neg_integer,
          amt_out: non_neg_integer,
          fee: non_neg_integer
        }
  defstruct [:timestamp, :chan_id_in, :chan_id_out, :amt_in, :amt_out, :fee]

  field :timestamp, 1, type: :uint64
  field :chan_id_in, 2, type: :uint64
  field :chan_id_out, 4, type: :uint64
  field :amt_in, 5, type: :uint64
  field :amt_out, 6, type: :uint64
  field :fee, 7, type: :uint64
end

defmodule Lnrpc.ForwardingHistoryResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          forwarding_events: [Lnrpc.ForwardingEvent.t()],
          last_offset_index: non_neg_integer
        }
  defstruct [:forwarding_events, :last_offset_index]

  field :forwarding_events, 1, repeated: true, type: Lnrpc.ForwardingEvent
  field :last_offset_index, 2, type: :uint32
end

defmodule Lnrpc.WalletUnlocker.Service do
  @moduledoc false
  use GRPC.Service, name: "lnrpc.WalletUnlocker"

  rpc :GenSeed, Lnrpc.GenSeedRequest, Lnrpc.GenSeedResponse
  rpc :InitWallet, Lnrpc.InitWalletRequest, Lnrpc.InitWalletResponse
  rpc :UnlockWallet, Lnrpc.UnlockWalletRequest, Lnrpc.UnlockWalletResponse
  rpc :ChangePassword, Lnrpc.ChangePasswordRequest, Lnrpc.ChangePasswordResponse
end

defmodule Lnrpc.WalletUnlocker.Stub do
  @moduledoc false
  use GRPC.Stub, service: Lnrpc.WalletUnlocker.Service
end

defmodule Lnrpc.Lightning.Service do
  @moduledoc false
  use GRPC.Service, name: "lnrpc.Lightning"

  rpc :WalletBalance, Lnrpc.WalletBalanceRequest, Lnrpc.WalletBalanceResponse
  rpc :ChannelBalance, Lnrpc.ChannelBalanceRequest, Lnrpc.ChannelBalanceResponse
  rpc :GetTransactions, Lnrpc.GetTransactionsRequest, Lnrpc.TransactionDetails
  rpc :SendCoins, Lnrpc.SendCoinsRequest, Lnrpc.SendCoinsResponse
  rpc :SubscribeTransactions, Lnrpc.GetTransactionsRequest, stream(Lnrpc.Transaction)
  rpc :SendMany, Lnrpc.SendManyRequest, Lnrpc.SendManyResponse
  rpc :NewAddress, Lnrpc.NewAddressRequest, Lnrpc.NewAddressResponse
  rpc :SignMessage, Lnrpc.SignMessageRequest, Lnrpc.SignMessageResponse
  rpc :VerifyMessage, Lnrpc.VerifyMessageRequest, Lnrpc.VerifyMessageResponse
  rpc :ConnectPeer, Lnrpc.ConnectPeerRequest, Lnrpc.ConnectPeerResponse
  rpc :DisconnectPeer, Lnrpc.DisconnectPeerRequest, Lnrpc.DisconnectPeerResponse
  rpc :ListPeers, Lnrpc.ListPeersRequest, Lnrpc.ListPeersResponse
  rpc :GetInfo, Lnrpc.GetInfoRequest, Lnrpc.GetInfoResponse
  rpc :PendingChannels, Lnrpc.PendingChannelsRequest, Lnrpc.PendingChannelsResponse
  rpc :ListChannels, Lnrpc.ListChannelsRequest, Lnrpc.ListChannelsResponse
  rpc :ClosedChannels, Lnrpc.ClosedChannelsRequest, Lnrpc.ClosedChannelsResponse
  rpc :OpenChannelSync, Lnrpc.OpenChannelRequest, Lnrpc.ChannelPoint
  rpc :OpenChannel, Lnrpc.OpenChannelRequest, stream(Lnrpc.OpenStatusUpdate)
  rpc :CloseChannel, Lnrpc.CloseChannelRequest, stream(Lnrpc.CloseStatusUpdate)
  rpc :AbandonChannel, Lnrpc.AbandonChannelRequest, Lnrpc.AbandonChannelResponse
  rpc :SendPayment, stream(Lnrpc.SendRequest), stream(Lnrpc.SendResponse)
  rpc :SendPaymentSync, Lnrpc.SendRequest, Lnrpc.SendResponse
  rpc :SendToRoute, stream(Lnrpc.SendToRouteRequest), stream(Lnrpc.SendResponse)
  rpc :SendToRouteSync, Lnrpc.SendToRouteRequest, Lnrpc.SendResponse
  rpc :AddInvoice, Lnrpc.Invoice, Lnrpc.AddInvoiceResponse
  rpc :ListInvoices, Lnrpc.ListInvoiceRequest, Lnrpc.ListInvoiceResponse
  rpc :LookupInvoice, Lnrpc.PaymentHash, Lnrpc.Invoice
  rpc :SubscribeInvoices, Lnrpc.InvoiceSubscription, stream(Lnrpc.Invoice)
  rpc :DecodePayReq, Lnrpc.PayReqString, Lnrpc.PayReq
  rpc :ListPayments, Lnrpc.ListPaymentsRequest, Lnrpc.ListPaymentsResponse
  rpc :DeleteAllPayments, Lnrpc.DeleteAllPaymentsRequest, Lnrpc.DeleteAllPaymentsResponse
  rpc :DescribeGraph, Lnrpc.ChannelGraphRequest, Lnrpc.ChannelGraph
  rpc :GetChanInfo, Lnrpc.ChanInfoRequest, Lnrpc.ChannelEdge
  rpc :GetNodeInfo, Lnrpc.NodeInfoRequest, Lnrpc.NodeInfo
  rpc :QueryRoutes, Lnrpc.QueryRoutesRequest, Lnrpc.QueryRoutesResponse
  rpc :GetNetworkInfo, Lnrpc.NetworkInfoRequest, Lnrpc.NetworkInfo
  rpc :StopDaemon, Lnrpc.StopRequest, Lnrpc.StopResponse
  rpc :SubscribeChannelGraph, Lnrpc.GraphTopologySubscription, stream(Lnrpc.GraphTopologyUpdate)
  rpc :DebugLevel, Lnrpc.DebugLevelRequest, Lnrpc.DebugLevelResponse
  rpc :FeeReport, Lnrpc.FeeReportRequest, Lnrpc.FeeReportResponse
  rpc :UpdateChannelPolicy, Lnrpc.PolicyUpdateRequest, Lnrpc.PolicyUpdateResponse
  rpc :ForwardingHistory, Lnrpc.ForwardingHistoryRequest, Lnrpc.ForwardingHistoryResponse
end

defmodule Lnrpc.Lightning.Stub do
  @moduledoc false
  use GRPC.Stub, service: Lnrpc.Lightning.Service
end
