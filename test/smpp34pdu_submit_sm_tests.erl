-module(smpp34pdu_submit_sm_tests).
-include("../include/smpp34pdu.hrl").
-include_lib("eunit/include/eunit.hrl").

submit_sm_no_tlv_test_() ->
	PayLoad = #submit_sm{service_type="CMT",
		source_addr_ton=2,
		source_addr_npi=1,
		source_addr="abcd",
		dest_addr_ton=2,
		dest_addr_npi=1,
		destination_addr="efgh",
		esm_class=1,
		protocol_id=2,
		priority_flag=1,
		schedule_delivery_time="100716133059001+",
		validity_period="000014000000000R",
		registered_delivery=1,
		replace_if_present_flag=1,
		data_coding=1,
		sm_default_msg_id=1,
		sm_length=11,
		short_message="hello world"},

	Bin = <<67,77,84,0,
			2,1,
			97,98,99,100,0,
			2,1,
			101,102,103,104,0,
			1,2,1,
			$1,$0,$0,$7,$1,$6,$1,$3,$3,$0,$5,$9,$0,$0,$1,$+,0,
			$0,$0,$0,$0,$1,$4,$0,$0,$0,$0,$0,$0,$0,$0,$0,$R,0,
			1,1,1,1,11,
			104,101,108,108,111,32,119,111,114,108,100>>,

	[
		{"Packing PayLoad will give Bin",
			?_assertEqual(Bin, smpp34pdu_submit_sm:pack(PayLoad))},
		{"Unpacking Bin will give PayLoad",
			?_assertEqual(PayLoad, smpp34pdu_submit_sm:unpack(Bin))},
		{"Packing and Unpacking PayLoad will give you PayLoad",
			?_assertEqual(PayLoad,
						smpp34pdu_submit_sm:unpack(smpp34pdu_submit_sm:pack(PayLoad)))},
		{"Unpacking and Packing Bin will give you Bin",
			?_assertEqual(Bin, 
						smpp34pdu_submit_sm:pack(smpp34pdu_submit_sm:unpack(Bin)))}
	].
