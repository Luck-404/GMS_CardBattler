//===============================================================================//
//
// SCRIPT: SCR_WORLD_EVENT_ENUMS
// FUNCTION: Defines the lifecycle states used by the persistent World Event
//           controller. Phase I establishes state vocabulary only; timers and
//           gameplay transitions are implemented in later phases.
//
//===============================================================================//

enum ENUM_WORLD_EVENT_STATE{
	NONE = 0,
	ANNOUNCED = 1,
	ACTIVE = 2,
	COMPLETED = 3,
	EXPIRED = 4,
	CLEANUP = 5
}
