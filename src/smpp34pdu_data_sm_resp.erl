-module(smpp34pdu_data_sm_resp).
-include("smpp34pdu.hrl").
-include("types.hrl").
-include("tlv_macros.hrl").
-export([pack/1,unpack/1]).
-import(pdu_data, [cstring_to_bin/2, integer_to_bin/2]).
-import(pdu_data, [bin_to_cstring/2, bin_to_integer/2]).

-spec(pack/1 :: (data_sm_resp()) -> binary()).
-spec(unpack/1 :: (binary()) -> data_sm_resp()).

pack(#data_sm_resp{message_id=MessageId,
		delivery_failure_reason=DeliveryFailureReason,
		network_error_code=NetworkErrorCode,
		additional_status_info_text=AdditionalStatusInfoText,
		dpf_result=DpfResult}) ->


		L = [cstring_to_bin(MessageId, 65),
					   tlv:pack(?DELIVERY_FAILURE_REASON, DeliveryFailureReason),
					   tlv:pack(?NETWORK_ERROR_CODE, NetworkErrorCode),
					   tlv:pack(?ADDITIONAL_STATUS_INFO_TEXT, AdditionalStatusInfoText),
					   tlv:pack(?DPF_RESULT, DpfResult)],

		list_to_binary(L).


unpack(Bin0) ->
	{MessageId, Bin1} = bin_to_cstring(Bin0, 65),

	unpack_tlv_fields(Bin1, #data_sm_resp {message_id=MessageId}).

?TLV_UNPACK_EMPTY_BIN;
?TLV_UNPACK_FIELD(data_sm_resp, delivery_failure_reason, ?DELIVERY_FAILURE_REASON);
?TLV_UNPACK_FIELD(data_sm_resp, network_error_code, ?NETWORK_ERROR_CODE);
?TLV_UNPACK_FIELD(data_sm_resp, additional_status_info_text, ?ADDITIONAL_STATUS_INFO_TEXT);
?TLV_UNPACK_FIELD(data_sm_resp, dpf_result, ?DPF_RESULT);
?TLV_UNPACK_UNEXPECTED.
