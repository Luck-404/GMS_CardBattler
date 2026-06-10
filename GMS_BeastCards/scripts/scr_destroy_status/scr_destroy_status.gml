//
// scr_destroy_status(_status)
// Removes status from its owning list and destroys it
//
function scr_destroy_status(_status)
{
    if (!instance_exists(_status)) exit;

    //--------------------------------------------------
    // GLOBAL STATUS
    //--------------------------------------------------
    if (_status._ref_host == undefined)
    {
		var _s = scr_check_for_status(_status._status_name,global.statuses);
		if (_s != -1){
			var _i = ds_list_find_index(global.statuses, _s);	
		    if (_i != -1)
		    {
		        ds_list_delete(global.statuses, _i);
		    }

		    instance_destroy(_s);

		    scr_reposition_statuses(global.statuses);
		}
		exit;		
    }

    //--------------------------------------------------
    // HOST STATUS
    //--------------------------------------------------
    var _host = _status._ref_host;

    if (instance_exists(_host))
    {
		var _s = scr_check_for_status(_status._status_name,_host);
		if (_s != -1){		
			var _i = ds_list_find_index(_host._statuses,_s);
			
	        if (_i != -1)
	        {
	            ds_list_delete(_host._statuses, _i);
	        }			
	        instance_destroy(_s);

	        scr_reposition_statuses(_host);			
		}
    }
    else
    {
        instance_destroy(_status);
    }
}