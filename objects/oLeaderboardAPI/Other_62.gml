/// @desc Get Data

if async_load[? "id"] == httpID {
	if async_load[? "status"] == 0 {
		callbackFunction(json_parse(async_load[? "result"]));
	}
}