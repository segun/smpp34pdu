-module(smpp34pdu_bind_transceiver_resp).
-include("smpp34pdu.hrl").
-include("types.hrl").
-include("tlv_macros.hrl").
-export([pack/1,unpack/1]).
-import(pdu_data, [cstring_to_bin/2]).
-import(pdu_data, [bin_to_cstring/2]).

-spec(pack/1 :: (bind_transceiver_resp()) -> binary()).
-spec(unpack/1 :: (binary()) -> bind_transceiver_resp()).
-spec(unpack_tlv_fields/2 :: (binary(), bind_transceiver_resp()) -> bind_transceiver_resp()).

pack(#bind_transceiver_resp{system_id=SystemId, 
		sc_interface_version=ScIntVersion}) ->

		L = [cstring_to_bin(SystemId, 16),
					   tlv:pack(?SC_INTERFACE_VERSION, ScIntVersion)],

		list_to_binary(L).


unpack(Bin0) ->
	{SystemId, Bin1} = bin_to_cstring(Bin0, 16),
	unpack_tlv_fields(Bin1, #bind_transceiver_resp{system_id=SystemId}).


?TLV_UNPACK_EMPTY_BIN;
?TLV_UNPACK_FIELD(bind_transceiver_resp, sc_interface_version, ?SC_INTERFACE_VERSION);
?TLV_UNPACK_UNEXPECTED.
