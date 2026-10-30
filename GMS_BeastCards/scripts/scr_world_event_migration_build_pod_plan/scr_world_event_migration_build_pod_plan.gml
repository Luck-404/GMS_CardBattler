//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_MIGRATION_BUILD_POD_PLAN
// FUNCTION: Builds a valid Migration population/pod layout against the currently
//           available unique MOB spawn anchors.
//
//           Each pod contains 3-5 members and never exceeds its anchor capacity.
//           Each selected pod receives a unique anchor.
//
// ARGUMENTS: _ct_population_requested - Preferred total population.
//            _arr_spawn_points - Compatible live MOB spawn-point instances.
//            _ct_population_min - Minimum acceptable Migration population.
//            _ct_pod_min / _ct_pod_max - Pod-size bounds.
// RETURNS: Struct containing _flag_valid, _ct_population, and _arr_pods.
//
//===============================================================================//

function scr_world_event_migration_build_pod_plan(
	_ct_population_requested,
	_arr_spawn_points,
	_ct_population_min=10,
	_ct_pod_min=3,
	_ct_pod_max=5
){

	var _stct_fail = {
		_flag_valid : false,
		_ct_population : 0,
		_arr_pods : []
	};

	if (
		!is_array(
			_arr_spawn_points
		) ||
		array_length(
			_arr_spawn_points
		) <= 0
	){
		return _stct_fail;
	}

	_ct_population_min =
		max(
			1,
			floor(
				_ct_population_min
			)
		);

	_ct_pod_min =
		max(
			1,
			floor(
				_ct_pod_min
			)
		);

	_ct_pod_max =
		max(
			_ct_pod_min,
			floor(
				_ct_pod_max
			)
		);

	_ct_population_requested =
		max(
			_ct_population_min,
			floor(
				_ct_population_requested
			)
		);

	// Try the requested population first, then gracefully reduce toward the
	// approved minimum if room-authoring capacities cannot support the first roll.
	for (
		var _ct_population = _ct_population_requested;
		_ct_population >= _ct_population_min;
		_ct_population--
	){

		var _ct_min_pods =
			ceil(
				_ct_population /
					_ct_pod_max
			);

		var _ct_max_pods =
			min(
				floor(
					_ct_population /
						_ct_pod_min
				),
				array_length(
					_arr_spawn_points
				)
			);

		if (_ct_min_pods > _ct_max_pods){
			continue;
		}

		// Random selection retries keep pod placement varied while respecting
		// mixed per-anchor capacities.
		for (
			var _it_attempt = 0;
			_it_attempt < 64;
			_it_attempt++
		){

			var _ct_pods =
				irandom_range(
					_ct_min_pods,
					_ct_max_pods
				);

			var _list_candidates =
				ds_list_create();

			for (
				var _it_candidate = 0;
				_it_candidate <
					array_length(
						_arr_spawn_points
					);
				_it_candidate++
			){

				var _ref_candidate =
					_arr_spawn_points[
						_it_candidate
					];

				if (!instance_exists(_ref_candidate)){
					continue;
				}

				if (
					_ref_candidate._ct_spawn_capacity <
					_ct_pod_min
				){
					continue;
				}

				ds_list_add(
					_list_candidates,
					_ref_candidate
				);
			}

			if (
				ds_list_size(
					_list_candidates
				) <
				_ct_pods
			){

				ds_list_destroy(
					_list_candidates
				);

				continue;
			}

			var _arr_selected = [];

			for (
				var _it_pick = 0;
				_it_pick < _ct_pods;
				_it_pick++
			){

				var _it_candidate_pick =
					irandom(
						ds_list_size(
							_list_candidates
						) -
						1
					);

				var _ref_pick =
					ds_list_find_value(
						_list_candidates,
						_it_candidate_pick
					);

				ds_list_delete(
					_list_candidates,
					_it_candidate_pick
				);

				array_push(
					_arr_selected,
					_ref_pick
				);
			}

			ds_list_destroy(
				_list_candidates
			);

			var _arr_sizes =
				array_create(
					_ct_pods,
					_ct_pod_min
				);

			var _arr_extra_capacity =
				array_create(
					_ct_pods,
					0
				);

			var _ct_extra_capacity_total = 0;

			for (
				var _it_pod = 0;
				_it_pod < _ct_pods;
				_it_pod++
			){

				var _ct_anchor_max =
					min(
						_ct_pod_max,
						floor(
							_arr_selected[
								_it_pod
							]
							._ct_spawn_capacity
						)
					);

				_arr_extra_capacity[
					_it_pod
				] =
					max(
						0,
						_ct_anchor_max -
							_ct_pod_min
					);

				_ct_extra_capacity_total +=
					_arr_extra_capacity[
						_it_pod
					];
			}

			var _ct_extras =
				_ct_population -
				(
					_ct_pods *
					_ct_pod_min
				);

			if (_ct_extra_capacity_total < _ct_extras){
				continue;
			}

			while (_ct_extras > 0){

				var _arr_extra_candidates = [];

				for (
					var _it_pod = 0;
					_it_pod < _ct_pods;
					_it_pod++
				){

					if (
						_arr_extra_capacity[
							_it_pod
						] >
						0
					){
						array_push(
							_arr_extra_candidates,
							_it_pod
						);
					}
				}

				if (
					array_length(
						_arr_extra_candidates
					) <=
					0
				){
					break;
				}

				var _it_pod_pick =
					_arr_extra_candidates[
						irandom(
							array_length(
								_arr_extra_candidates
							) -
							1
						)
					];

				_arr_sizes[
					_it_pod_pick
				]++;

				_arr_extra_capacity[
					_it_pod_pick
				]--;

				_ct_extras--;
			}

			if (_ct_extras > 0){
				continue;
			}

			var _arr_plan = [];

			for (
				var _it_pod = 0;
				_it_pod < _ct_pods;
				_it_pod++
			){

				array_push(
					_arr_plan,
					{
						_ref_spawn_point :
							_arr_selected[
								_it_pod
							],

						_ct_pod_size :
							_arr_sizes[
								_it_pod
							]
					}
				);
			}

			return {
				_flag_valid : true,
				_ct_population : _ct_population,
				_arr_pods : _arr_plan
			};
		}
	}

	return _stct_fail;
}
