global function AutomaticEjection


void function AutomaticEjection() {
    if ( IsMultiplayer() )
    {
        AddCallback_GameStateEnter( eGameState.Epilogue, AutomaticEjectionMain )
    }
}

void function AutomaticEjectionMain(){
	entity player = GetLocalViewPlayer()
	entity cockpit = player.GetCockpit()
    if ( !player.IsTitan() )
    return
    if ( !IsAlive( player ) )
    return
    if ( IsValid( player.GetParent() ) )
    return
    if ( TitanEjectIsDisabled() )
    {
        EmitSoundOnEntity( player, "CoOp_SentryGun_DeploymentDeniedBeep" )
        SetTimedEventNotification( 1.5, "" )
        SetTimedEventNotification( 1.5, "#NOTIFY_EJECT_DISABLED" )
        return
    }
    if ( Riff_TitanExitEnabled() == eTitanExitEnabled.Never || 	Riff_TitanExitEnabled() == eTitanExitEnabled.DisembarkOnly )
    return
    if ( player.ContextAction_IsMeleeExecution() )
    return
    PlayerEjects( player, cockpit )
    player.ClientCommand( "TitanEject " + 3 )
}