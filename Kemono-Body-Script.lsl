/* <- Enlarge window so you see this on only one line for better visibility ->
*
* Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life
* Original creation date: 6/06/2017 22:52:37
* The latest version of this script is located at:
* https://github.com/XenHat/Kemono-Body-Script/blob/master/Kemono-Body-Script.lsl
*
* Licensed under the Aladdin Free Public License Version 9
* For the Full license, see
*  https://tldrlegal.com/license/aladdin-free-public-license#fulltext
*
* The short human readable version of this licence for the benefit of the
* reader is:
*
* You CAN:
* Modify
* Distribute
*
* You CANNOT:
*  Hold Liable
*  Sublicense
*  Place Warranty
*  Commercial Use
*
* You MUST:
*  Include License
*  Include Original
*  State Changes
*
* An online version of the human-readable version of the AFPL can be found at:
* https://tldrlegal.com/license/aladdin-free-public-license
*
* WARNING: Currently the script does not allow custom coloring to be retained
* due to the way I preserve texturing without needing an applier script.
*
* Please contact the author of this script if you wish to trade that
* functionality
* for custom coloring support (You will need a full-perm copy of your skin
* for the texturing to work at all.
* This is because I do not have the info required to support the kApp applier.
*
.oPYo.               d'b  o                              o   o
8    8               8                                   8
8      .oPYo. odYo. o8P  o8 .oPYo. o    o oPYo. .oPYo.  o8P o8 .oPYo. odYo.
8      8    8 8' `8  8    8 8    8 8    8 8  `' .oooo8   8   8 8    8 8' `8
8    8 8    8 8   8  8    8 8    8 8    8 8     8    8   8   8 8    8 8   8
`YooP' `YooP' 8   8  8    8 `YooP8 `YooP' 8     `YooP8   8   8 `YooP' 8   8
:.....::.....:..::..:..:::..:....8 :.....:..:::::.....:::..::..:.....:..::..
::::::::::::::::::::::::::::::ooP'.:::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::...:::::::::::::::::::::::::::::::::::::::::::
*/
/* May not be available in all viewers */
// #define USE_OPTIMIZER
float g_Config_MaximumOpacity=1.00; // 0.8 // for goo
/*-------------------------------------------------------------------------- */
/* NO USER-EDITABLE VALUES BELOW THIS LINE */
#define g_internal_version_s "0.3.28" /* NOTE: Only bump on bugfix ok?*/
/* Debugging */
/* TODO: Remove no longer needed code toggles here */
// #define BENCHMARK
// #define PRINT_UNHANDLED_COMMANDS
// #define DEBUG
// #define DEBUG_SELF_TEST
// #define DEBUG_TEXT
// #define DEBUG_AUTH
// #define DEBUG_ENTIRE_BODY_ALPHA
// #define DEBUG_LISTEN
// #define DEBUG_LISTEN_LITE
// #define DEBUG_COMMAND
// #define DEBUG_DATA
// #define DEBUG_PARAMS
// #define DEBUG_FACE_SELECT
// #define DEBUG_FACE_TOUCH
// #define DEBUG_FUNCTIONS
/* End of debug defines */
/* Normal Features that should be enabled */
#define USE_DEFORM_ANIMS
// #define SMART_DEFORM
#ifdef SMART_DEFORM
/* UNDEFORM_BY_DEFAULT fixes most animation alignment issues, at a cost:
Your shoulders will appear larger than they should. Small price to pay to not
look stupid in all other cases
*/
// #define UNDEFORM_BY_DEFAULT
    #ifdef UNDEFORM_BY_DEFAULT
        integer undeform_instead=TRUE;
    #else
        integer undeform_instead=FALSE;
    #endif
#endif
#ifndef DISABLE_GITHUB_UPDATER
#define GITHUB_UPDATER
#endif
#define PROCESS_LEGS_COMMANDS
#define HOVER_TEXT_COLOR <0.925,0.925,0.925>
#define HOVER_TEXT_ALPHA 0.75
#ifdef DEBUG
#define xlSetLinkPrimitiveParamsFast(a,b) llOwnerSay("PARAMS:"+llList2CSV(b));\
llSetLinkPrimitiveParamsFast(a,b)
#else
#define xlSetLinkPrimitiveParamsFast(a,b) llSetLinkPrimitiveParamsFast(a,b)
#endif
#ifdef DEBUG
#define debugLogic(a) llOwnerSay(#a + " == " + (string)a)
#define dSay(a) llOwnerSay((string)a)
#else
#define debugLogic(a) //
#define dSay(a) //
#endif
string KM_HUD_RESET_CMD = "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR";
/* TODO:
-   Set Nipple Alpha
        0 = None : 1 = Partial : 2 = Full
        0 being replaced by the state number 0 ~ 2:
        nipalpha:0
-   Set Nipple Override
        0 = Off : 1 = On
        0 being replaced by the state number 0 ~ 1:
        nipovrd:0
- Send reqCLdat and handle reply 'resCLdat' (ie  'resCLdat:clothID:1033:clothDesc:Top:attachPoint:1:clothState:0')
- Leg types toggles, see comments below
*/
#define KEMONO_COM_CH -34525475
#define API_CMD_ABS "abs"
#define API_CMD_ANKLE_L "ankleL"
#define API_CMD_ANKLE_R "ankleR"
#define API_CMD_ARM_L_L "armLL"
#define API_CMD_ARM_L_R "armLR"
#define API_CMD_ARM_U_L "armUL"
#define API_CMD_ARM_U_R "armUR"
#define API_CMD_BELLY "belly"
#define API_CMD_BREASTS "breast"
#define API_CMD_CALF_L "calfL"
#define API_CMD_CALF_R "calfR"
#define API_CMD_CHEST "chest"
#define API_CMD_COLLAR "collar"
#define API_CMD_ELBOW_L "elbowL"
#define API_CMD_ELBOW_R "elbowR"
#define API_CMD_FITTED_TORSO "Fitted Torso Old Root"
#define API_CMD_FOOT_L "footL"
#define API_CMD_FOOT_R "footR"
#define API_CMD_HIP_L "hipL"
#define API_CMD_HIP_R "hipR"
#define API_CMD_KNEE_L "kneeL"
#define API_CMD_KNEE_R "kneeR"
#define API_CMD_NIPS "nips"
#define API_CMD_PELVIS "pelvis"
#define API_CMD_RIBS "ribs"
#define API_CMD_SHIN_L_L "shinLL"
#define API_CMD_SHIN_L_R "shinLR"
#define API_CMD_SHIN_U_L "shinUL"
#define API_CMD_SHIN_U_R "shinUR"
#define API_CMD_SHOULDER_L_L "shoulderLL"
#define API_CMD_SHOULDER_L_R "shoulderLR"
#define API_CMD_SHOULDER_U_L "shoulderUL"
#define API_CMD_SHOULDER_U_R "shoulderUR"
#define API_CMD_THIGH_L_L "thighLL"
#define API_CMD_THIGH_L_R "thighLR"
#define API_CMD_THIGH_U_L "thighUL"
#define API_CMD_THIGH_U_R "thighUR"
#define API_CMD_VAG "vagoo"
#define API_CMD_VIRTUAL_BUTT "butt"
#define API_CMD_WRIST_L "wristL"
#define API_CMD_WRIST_R "wristR"
#define MESH_ARMS "arms"
#define MESH_BODY "body"
#define MESH_FITTED_TORSO "Fitted Kemono Torso"
#define MESH_FITTED_TORSO_CHEST "TorsoChest"
#define MESH_FITTED_TORSO_ETC "TorsoEtc"
#define MESH_FITTED_TORSO_HLEGS "HumanLegs"
#define MESH_FITTED_TORSO_NIP_0 "NipState0"
#define MESH_FITTED_TORSO_NIP_1 "NipState1"
#define MESH_FITTED_TORSO_NIP_A "NipAlpha"
#define MESH_HAND_LEFT "handL"
#define MESH_HAND_RIGHT "handR"
#define MESH_HIPS "hips"
#define MESH_LEG_LEFT_ANIMAL "LFleg"
#define MESH_LEG_LEFT_HUMAN "LHleg"
#define MESH_LEG_RIGHT_ANIMAL "RFleg"
#define MESH_LEG_RIGHT_HUMAN "RHleg"
#define MESH_NECK "neck"
#define MESH_PG_LAYER "PG"
#define MESH_ROOT "Kemono - Body"
#define MESH_SK_NIPS "nips"
#define MESH_SK_VAGOO "vagoo"
#define g_supported_meshes [\
"BitState0",\
"BitState1",\
"BitState2",\
"BitState3",\
"cumButtS1",\
"cumButtS2",\
"cumButtS3",\
MESH_ARMS,\
MESH_BODY,\
MESH_FITTED_TORSO,\
MESH_FITTED_TORSO_CHEST,\
MESH_FITTED_TORSO_ETC,\
MESH_FITTED_TORSO_HLEGS,\
MESH_FITTED_TORSO_NIP_0,\
MESH_FITTED_TORSO_NIP_1,\
MESH_FITTED_TORSO_NIP_A,\
MESH_HAND_LEFT,\
MESH_HAND_RIGHT,\
MESH_HIPS,\
MESH_LEG_LEFT_ANIMAL,\
MESH_LEG_LEFT_HUMAN,\
MESH_LEG_RIGHT_ANIMAL,\
MESH_LEG_RIGHT_HUMAN,\
MESH_NECK,\
MESH_PG_LAYER,\
MESH_ROOT\
]
list s_FittedNipsMeshNames =[
MESH_FITTED_TORSO_NIP_0,/* 0, visible: PG mesh, hidden: ALpha stage 2*/
MESH_FITTED_TORSO_ETC,/* 1 */
MESH_FITTED_TORSO_NIP_1, /* 2 */
MESH_FITTED_TORSO_NIP_A /* alpha stage 1 */
];
list s_KFTPelvisMeshes = [
"BitState0",
"BitState1",
"BitState2",
"BitState3"
];
#define FKT_PRESENT 1
/* PG States */
#define KSB_PGVAGOO 2
#define KSB_PGNIPLS 4
/* Flags for blade sync purposes*/
#define MOD_SB_FKT_BUTT 8
#define MOD_SB_FKT_NIPS 16
#define MOD_SB_FKT_VAGN 32
#define MOD_SB_FKT_NIPH 64
/* Some shorthand operators are not allowed in LSL, so let's do some hackery
*    usage:
*        a=variable/set
*        b=bit (define, see above)
*/
#define bwChange(a,b,c) a=(a & (~b)) | (b * c);
#define bwClear(a,b) a=(a & (~b))
#define bwGet(a,b) (!!(a & b))
#define bwSet(a,b) a=(a | b)
#define bwToggle(a,b) a ^=1 << b
#define xlListLen2MaxID(a) ((llGetListLength(a))-1)
/* === Updater settings === */
#define compiled_name "xenhat.kemono.body.lsl"
#define g_internal_repo_s "XenHat/"+script_name
#define script_name "Kemono-Body-Script"
/* === Runtime settings and values === */
/* TODO: Use a bitset if we run out of memory */
#define g_DefaultFittedButState 1
#define g_DefaultFittedNipAlpha 0
#define g_DefaultFittedNipState 1
#define g_DefaultFittedVagState 1
integer g_CurrentFittedButState=1;
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedNipAlpha=0;
integer g_CurrentFittedVagState=1;
integer g_PreviousFittedButState=1;
integer g_PreviousFittedNipState=1;
integer g_PreviousFittedNipAlpha=0;
integer g_PreviousFittedVagState=1;
integer g_HasAnimPerms=FALSE;
integer g_RuntimeBodyStateSettings;
integer g_TogglingPGMeshes=FALSE;
integer human_mode=TRUE; /* Prefer when available*/
#ifdef GITHUB_UPDATER
key g_internal_httprid_k=NULL_KEY;
#endif
key g_Owner_k;
key g_Last_k;
list g_LinkDB_l=[];
list g_AttmntAuthedKeys_l;
string g_LastCommand_s;
/* Overridable deform animation */
string g_AnimDeform;
string g_AnimUndeform;
/* === User Functions === */
list xlGetFacesByBladeName(string name){
    #ifdef DEBUG_COMMAND
    llOwnerSay("===== xlGetFacesByBladeName =====");
    #endif
    if(name==API_CMD_ABS) return [6,7];
    if(name==API_CMD_ANKLE_L){
        if(human_mode) return [1];
        return [5];
    }
    if(name==API_CMD_ANKLE_R){
        if(human_mode)
            return [1];
        return [5];
    }
    if(name==API_CMD_ARM_L_L) return [7];
    if(name==API_CMD_ARM_L_R) return [2];
    if(name==API_CMD_ARM_U_L) return [0];
    if(name==API_CMD_ARM_U_R) return [6];
    if(name==API_CMD_BELLY) return [2,3];
    if(name==MESH_BODY) return [0];
    if(name==API_CMD_BREASTS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [2,3];
        return [2,5];
    }
    if(name==API_CMD_CALF_L){
        if(human_mode)
            return [4];
        return [2];
    }
    if(name==API_CMD_CALF_R){
        if(human_mode)
            return [4];
        return [2];
    }
    if(name==API_CMD_CHEST){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1];
        if(human_mode)
            return [0,4];
        return [0,4];
    }
    if(name==API_CMD_COLLAR){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [6,7];
        return [1,6];
    }
    if(name==API_CMD_ELBOW_L) return [4];
    if(name==API_CMD_ELBOW_R) return [5];
    if(name==API_CMD_FOOT_L) return [0];
    if(name==API_CMD_FOOT_R) return [0];
    if(name==API_CMD_HIP_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [6];
    }
    if(name==API_CMD_HIP_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [4];
        return [5];
    }
    if(name==API_CMD_KNEE_L){
        if(human_mode)
            return [5];
        return [1];
    }
    if(name==API_CMD_KNEE_R){
        if(human_mode)
            return [5];
        return [1];
    }
    if(name==MESH_HAND_LEFT)
        return [-1];
    if(name==MESH_HAND_RIGHT)
        return [-1];
    if(name==MESH_NECK){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1];
        return [2,5];
    }
    if(name==MESH_SK_NIPS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            /* Note: Before changing this again, create a different way of
            *  handling the request that doesn't match.
            * This is configured properly for the whole Fitted Torso chest mesh
            */
            return [0,1];
        return [2,3];
    }
    if(name==API_CMD_PELVIS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1,2,3];
        return [0,1];
    }
    if(name==API_CMD_RIBS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [4,5];
        return [1,3];
    }
    if(name==API_CMD_SHIN_L_L){
        if(human_mode)
            return [2];
        return [4];
    }
    if(name==API_CMD_SHIN_L_R){
        if(human_mode)
            return [2];
        return [4];
    }
    if(name==API_CMD_SHIN_U_L)
        return [3];
    if(name==API_CMD_SHIN_U_R)
        return [3];
    if(name==API_CMD_SHOULDER_L_L)
        return [3];
    if(name==API_CMD_SHOULDER_L_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [2];
        return [0];
    }
    if(name==API_CMD_SHOULDER_U_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [7];
    }
    if(name==API_CMD_SHOULDER_U_R)
        return [4];
    if(name==API_CMD_THIGH_L_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(human_mode){
                return [1];
            }
            return [7];
        }
        return [6];
    }
    if(name==API_CMD_THIGH_L_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(human_mode)
                return [0];
            return [6];
        }
        return [6];
    }
    if(name==API_CMD_THIGH_U_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [7];
    }
    if(name==API_CMD_THIGH_U_R) return [4];
    if(name==API_CMD_VAG){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            /* Reminder: On the Fitted Torso, this is the upper hip mesh half.
            * The bottom hip mesh half is controlled independently using
            * setbutt
            */
            if(g_TogglingPGMeshes)
                return [0,1,2,3,4,5];
            return [0,1];
        }
        return [0,1];
    }
    if(name==API_CMD_VIRTUAL_BUTT){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            /* Reminder: On the Fitted Torso, this is the upper hip mesh half.
            *  The bottom hip mesh half is controlled independently using
            *  setbutt
            */
            #ifdef DEBUG_COMMAND
            llOwnerSay("uuuuuuuuu["+(string)g_TogglingPGMeshes+"]");
            #endif
            if(g_TogglingPGMeshes){
                return [0,1,2,3,4,5];
            }
            return [2,3,4,5];
        }
        return [];
    }
    if(name==API_CMD_WRIST_L) return [3];
    if(name==API_CMD_WRIST_R) return [1];
    #ifdef DEBUG_COMMAND
    llOwnerSay("UNIMPLEMENTED:"+name+"!");
    #endif
    return [];
}
/* This function is like a "translator", it returns
the specialized mesh name when a generic one is provided.
i.e. When using the fitted torso. API_CMD_BREASTS => MESH_FITTED_TORSO_CHEST
This is where the "Compatibility" and "Support" magic happens, for the
most part.
I don't particularly like having a mandatory function call for this
but I can't think of a better way to handle it right now.
*/
list xlBladeNameToPrimNames(string name){
    /* TODO Can't we return the link number directly (using less than 512 bytes
    *  of code!) without an additional function call?
    */
    #ifdef DEBUG_FACE_SELECT
    llOwnerSay("xlBladeNameToPrimNames("+name+")");
    #endif
    if(name==API_CMD_ARM_L_L) return [MESH_ARMS];
    else if(name==API_CMD_ARM_L_R) return [MESH_ARMS];
    else if(name==API_CMD_ARM_U_L) return [MESH_ARMS];
    else if(name==API_CMD_ARM_U_R) return [MESH_ARMS];
    else if(name==API_CMD_ELBOW_L) return [MESH_ARMS];
    else if(name==API_CMD_ELBOW_R) return [MESH_ARMS];
    else if(name==API_CMD_WRIST_L) return [MESH_ARMS];
    else if(name==API_CMD_WRIST_R) return [MESH_ARMS];
    else if(name==API_CMD_RIBS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==API_CMD_ABS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==MESH_BODY){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==API_CMD_BREASTS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==API_CMD_CHEST){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==API_CMD_COLLAR){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==MESH_HAND_LEFT) return [MESH_HAND_LEFT];
    else if(name==MESH_HAND_RIGHT) return [MESH_HAND_RIGHT];
    else if(name==API_CMD_HIP_L || name==API_CMD_HIP_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        return [MESH_HIPS];
    }
    else if(name==MESH_NECK){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==API_CMD_PELVIS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        return [MESH_HIPS];
    }
    else if(name==API_CMD_KNEE_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_FOOT_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_ANKLE_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_SHIN_U_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_CALF_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_SHIN_L_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_CALF_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==API_CMD_ANKLE_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==API_CMD_FOOT_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==API_CMD_KNEE_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==API_CMD_SHIN_L_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==API_CMD_SHIN_U_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==API_CMD_SHOULDER_L_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==API_CMD_SHOULDER_L_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==API_CMD_SHOULDER_U_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==API_CMD_SHOULDER_U_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==API_CMD_THIGH_U_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_ETC];
        return [MESH_HIPS];
    }
    else if(name==API_CMD_THIGH_U_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_ETC];
        return [MESH_HIPS];
    }
    else if(name==API_CMD_BELLY){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_ETC];
        return [MESH_HIPS];
    }
    else if(name==MESH_SK_NIPS){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
        {
            if (1==g_CurrentFittedNipAlpha)
            {
                /* nip alpha stage 1 */
            return [MESH_FITTED_TORSO_NIP_A];
            }
            else if (2==g_CurrentFittedNipAlpha)
            {
                /*  nip alpha stage 2 */
                return [MESH_FITTED_TORSO_NIP_0];
            }
            else
            {
                return [llList2String(s_FittedNipsMeshNames,
                        g_CurrentFittedNipState)];
            }
        }
        return [MESH_PG_LAYER];
    }
    else if(name==MESH_FITTED_TORSO_NIP_A){
        dSay("yes, nipalpha was requested");
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_NIP_A];
        return [MESH_PG_LAYER];
    }
    else if(name==API_CMD_VAG){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(g_TogglingPGMeshes){
                return [llList2String(s_KFTPelvisMeshes,0)];
            }
            return [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        }
        return [MESH_PG_LAYER];
    }
    else if(name==API_CMD_THIGH_L_R){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(human_mode){
                return [MESH_FITTED_TORSO_HLEGS];
            }
            return [MESH_FITTED_TORSO_ETC];
        }
        if(human_mode){
            return [MESH_LEG_RIGHT_HUMAN];
        }
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==API_CMD_THIGH_L_L){
        if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(human_mode){
                return [MESH_FITTED_TORSO_HLEGS];
            }
            return [MESH_FITTED_TORSO_ETC];
        }
        if(human_mode){
            return [MESH_LEG_LEFT_HUMAN];
        }
        return [MESH_LEG_LEFT_ANIMAL];
    }
    #ifdef DEBUG_COMMAND
    llOwnerSay("=================================");
    #endif
    return [name];
}
/* Stock Fitted Torso script:
setnip0==NipState0
setnip1==TorsoEtc[0,1]
setnip2==NipState1
NipAlpha==????
*/
/* Note: The Starbright stock behavior is the following:
Show PG layer when hiding nipples
Forcefully set the current genital state to Adult, idle on PG disable
*/
xlProcessCommandWrapper()
{
    #ifdef DEBUG_COMMAND
    llOwnerSay("===== xlProcessCommandWrapper:"+g_LastCommand_s+"===== ");
    #endif
            if(g_LastCommand_s == KM_HUD_RESET_CMD){
                reset();
            }
            else if(g_LastCommand_s=="resetA")
                reset();
            else if(g_LastCommand_s=="resetB"){
                g_AttmntAuthedKeys_l=[];
                reset();
            }
            else if(g_LastCommand_s=="Hlegs"){
                //llOwnerSay("Switching to human legs");
                #ifdef PROCESS_LEGS_COMMANDS
                if(!human_mode){
                    g_LastCommand_s = "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(FALSE);
                    human_mode=TRUE;
                    g_LastCommand_s = "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(TRUE);
                }
                #endif
                llSetObjectDesc((string)(human_mode) + "," + g_internal_version_s);
            }
            else if(g_LastCommand_s=="Flegs"){
                #ifdef PROCESS_LEGS_COMMANDS
                if(human_mode){
                    g_LastCommand_s = "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(FALSE);
                    human_mode=FALSE;
                    g_LastCommand_s = "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
                    xlProcessCommand(TRUE);
                }
                #endif
                llSetObjectDesc((string)(human_mode) + "," + g_internal_version_s);
            }
            /* TODO: FIXME: Kind of brutal, should probably store the last hand anim or something.*/
            /* TODO: move all this below inside the command processor */
            else if(g_LastCommand_s == "Rhand:1"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStartAnimation("Kem-hand-R-relax");
                return;
            }
            else if(g_LastCommand_s == "Rhand:2"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-hold");
                return;
            }
            else if(g_LastCommand_s == "Rhand:3"){
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-fist");
                return;
            }
            else if(g_LastCommand_s == "Rhand:4"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-point");
                return;
            }
            else if(g_LastCommand_s == "Rhand:5"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-horns");
                return;
            }
            else if(g_LastCommand_s == "Lhand:1"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStartAnimation("Kem-hand-L-relax");
                return;
            }
            else if(g_LastCommand_s == "Lhand:2"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-hold");
                return;
            }
            else if(g_LastCommand_s == "Lhand:3"){
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-fist");
                return;
            }
            else if(g_LastCommand_s == "Lhand:4"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-point");
                return;
            }
            else if(g_LastCommand_s == "Lhand:5"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-horns");
                return;
            }
            else if("reqFTdat"==g_LastCommand_s){
                #ifdef DEBUG_FUNCTIONS
                llOwnerSay("Sending Data");
                #endif
                if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT)){
                    llRegionSayTo(g_Owner_k,KEMONO_COM_CH,"resFTdat:nipState:"
                        +(string)g_CurrentFittedNipState
                        +":nipAlpha:"+(string)g_CurrentFittedNipAlpha
                        +":nipOvrd:0" /* TODO: Implement Nipple Override */
                        +":vagState:"+(string)g_CurrentFittedVagState
                        +":buttState:"+(string)g_CurrentFittedButState
                        +":humLegs:"+(string)human_mode);
                }
                return;
            }
             else{
                #ifdef FTK_MULTI_DROP
                /* Ignore Starbright's Kemono Torso messages when handling that mesh*/
                if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                if(llSubStringIndex(name,MESH_FITTED_TORSO) > 3)
                return;
                #endif
                if(llSubStringIndex(g_LastCommand_s, "resCLdat")==0)
                {
                    /* This API isn't public, the best we can do is guess. */
                    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                    {
                        list data = llParseString2List(g_LastCommand_s,[":"], []);
                        /* ie 'resCLdat:clothID:1064:clothDesc:Top:attachPoint:30:clothState:2' */
                        /* integer clothID = llList2Integer(data,2); */
                        string clothDesc = llList2String(data,4);
                        integer attachPoint = llList2Integer(data,6);
                        /* integer clothState = llList2Integer(data,8); /*0:on, 1: pulled, 2: removed*/
                        /* NOTE: This is part of the internal Starbright API. We shouldn't know
                        /* how to handle this and that is fine. Staryna says it's for
                        /* careful ordering of stuff. Private and all.
                        /* However some commands are required to be handled here to ensure
                        /* clothing made for the FKT behave properly */
                        if("Top"==clothDesc)
                        {
                            if(0==attachPoint)
                            {
                                // Restore previous nip state
                                //g_CurrentFittedNipState=g_FKT_stored_nipstate;
                                // force visible for now ok?
                                // g_CurrentFittedNipAlpha=1;
                                g_LastCommand_s="setnip:"+(string)g_PreviousFittedNipState;
                                xlProcessCommand(TRUE);
                            }
                            else
                            {
                                // store nip state
                                g_PreviousFittedNipState=g_CurrentFittedNipState;
                            }
                        }
                    }
                    return;
                }
                xlProcessCommand(TRUE);
        }
    #ifdef DEBUG_COMMAND
    llOwnerSay("=================================");
    #endif
    }
xlProcessCommand(integer send_params)
{
#ifdef DEBUG_COMMAND
    llOwnerSay("===== xlProcessCommand =====");
#endif
    /*   == Some Information about the Kemono API spec ==
     Generally speaking, command chaining is limited to same-state body parts;
     it is not possible to combine show and hide commands together
     (ie 'hide:abs:show:hipR').
     Some examples:
     'add:show:abs:hipL:remove' - Does not work
     'add:show:abs:hipL' - Does not work
     'add', then 'show:abs:hipL' - Works
     It is currently unknown if "remove" can be chained as it does not seem to
     block further messages from a "removed" uuid.
    */
    list input_data = llParseString2List(g_LastCommand_s,[":"],[]);
    string command = llList2String(input_data,0);
    integer list_size = llGetListLength(input_data);
    debugLogic(list_size);
    integer index = 0;
    integer i_make_visible = -1;
    list local_params;
    integer mesh_count_index=0;
    #define CMD_GENITALS 2
    #define CMD_BODYCORE 4
    integer mod_command = -1;
    integer mod_command_2 = -1;
    for (;index < list_size ; index++)
    {
        debugLogic(index);
        debugLogic(i_make_visible);
        command = llList2String(input_data,index);
        /* evaluate non-standard commands before looping through stock api */
        if(0==index/*-1==i_make_visible*/)
        {
            debugLogic(command);
            if("setnip"==command)
            {
                // Completely ignore nipple changes if alpha mode is on
                //if(g_CurrentFittedNipAlpha)
                {
                    mesh_count_index=xlListLen2MaxID(s_FittedNipsMeshNames);
                    mod_command_2=CMD_GENITALS;
                    mod_command=MOD_SB_FKT_NIPS;
                }
            }
            else if("nipalpha"==command)
            {
                mesh_count_index=xlListLen2MaxID(s_FittedNipsMeshNames);
                mod_command_2=CMD_GENITALS;
                mod_command=MOD_SB_FKT_NIPH;
            }
            else if("setbutt"==command)
            {
                mesh_count_index=xlListLen2MaxID(s_KFTPelvisMeshes);
                mod_command_2=CMD_GENITALS;
                mod_command=MOD_SB_FKT_BUTT;
            }
            else if("setvag"==command)
            {
                mesh_count_index=xlListLen2MaxID(s_KFTPelvisMeshes);
                mod_command_2=CMD_GENITALS;
                mod_command=MOD_SB_FKT_VAGN;
            }
            else if("show"==command)
            {
                i_make_visible = TRUE;
            }
            else if ("hide"==command)
            {
                i_make_visible = FALSE;
            }
            else if("remove"==command){
                /* Object signals they no longer need to talk with the API;
                     Remove their key from the list of authorized attachments.
                     This object will need to use the 'add' command
                     to interact with us again
                */
                integer placeinlist=llListFindList(g_AttmntAuthedKeys_l,[g_Last_k]);
                if(placeinlist !=-1){
                    g_AttmntAuthedKeys_l=llDeleteSubList(g_AttmntAuthedKeys_l,
                        placeinlist,placeinlist);
                    #ifdef DEBUG_AUTH
                    llOwnerSay("Removed [" + (string)g_Last_k + "] (" + llKey2Name(g_Last_k) + ") from auth list");
                    #endif
                }
            }
            #ifdef PRINT_UNHANDLED_COMMANDS
            else
            {
                llOwnerSay("Unhandled command '"+command+"'");
            }
            #endif
        }
        else
        {
            /* non-standard command done, and/or show/hide set,
                 loop through the remaining parameters
            */
            debugLogic(command);
            if(mod_command<1){
                /* We need to identify these commands as genital commands
                otherwise they will be processed incorrectly in the
                non-genitals code path
                */
                if(API_CMD_NIPS==command)
                {
                    dSay("nips!");
                    mod_command_2=CMD_BODYCORE;
                    mod_command=KSB_PGNIPLS;
                }
                else if(API_CMD_VAG==command)
                {
                    dSay("vagoo!");
                    mod_command_2=CMD_BODYCORE;
                    mod_command=KSB_PGVAGOO;
                }
                else
                {
                    mod_command_2=CMD_BODYCORE;
                }
            }
            if(CMD_GENITALS==mod_command_2)
            {
                #ifdef DEBUG_COMMAND
                llOwnerSay("===== Genitals =====");
                #endif
                integer param = llList2Integer(input_data,index);
                debugLogic(param);
                #ifdef DEBUG_FUNCTIONS
                // llOwnerSay("===== xlSetGenitals =====");
                #endif
                string mesh_name="";
                for(;mesh_count_index > -1;mesh_count_index--)
                {
                    debugLogic(mesh_count_index);
                    debugLogic(mod_command);
                    /* Mods */
                    /* TODO: Use preprocessor-able checks to hard-code mods
                        for released compiled scripts*/
                    /*#ifndef SB_FKT*/
                    /* Standard Kemono API stuff */
                    //if(KSB_PGNIPLS==mod_command)
                    //{
                    //    dSay("Oh yeah!");
                    //    mesh_name=(string)xlBladeNameToPrimNames(MESH_SK_NIPS);
                    //}
                    //#else
                    if(KSB_PGNIPLS==mod_command)
                    {
                        dSay("OwO");
                    }
                    if(MOD_SB_FKT_NIPH==mod_command)
                    {
                        g_CurrentFittedNipAlpha=param;
                        dSay(g_CurrentFittedNipAlpha);
                        mesh_name=llList2String(s_FittedNipsMeshNames,mesh_count_index);
                        debugLogic(mesh_name);
                        // mesh_name=MESH_FITTED_TORSO_NIP_A;
                        i_make_visible=(g_CurrentFittedNipAlpha==1) * (mesh_count_index==3);
                        debugLogic(i_make_visible);
                        /* TODO: Properly implement:
                         Stage0 hides the alpha mesh, and shows TorsoEtc/PG meshes
                         Stage1 shows the alpha mesh AND hides the PG mesh
                         Stage2 hides the alpha mesh AND hides the PG mesh.
                         */
                         if(0==param)
                         {
                            mod_command=MOD_SB_FKT_NIPS;
                            // TODO: restore previous nip state
                            debugLogic(g_CurrentFittedNipState);
                            param=g_PreviousFittedNipState;

                         }
                         else
                         {
                             g_PreviousFittedNipState=g_CurrentFittedNipState;
                            debugLogic(g_CurrentFittedNipState);
                         }
                    }
                    if(MOD_SB_FKT_NIPS==mod_command)
                    {
                        g_CurrentFittedNipState=param;
                        dSay("YES1");
                        //if(!g_CurrentFittedNipAlpha)
                        {
                            {
                                i_make_visible=/*!g_CurrentFittedNipAlpha *
                                !bwGet(g_RuntimeBodyStateSettings,mod_command) */
                                (mesh_count_index==g_CurrentFittedNipState);
                                mesh_name=llList2String(s_FittedNipsMeshNames,mesh_count_index);
                            }
                        }
                        //else
                        //{
                        //    dSay("Ignoring nip change due to nip alpha mode");
                        //    i_make_visible=FALSE;
                        //}
                    }
                    else if(MOD_SB_FKT_VAGN==mod_command)
                    {
                        g_CurrentFittedVagState=param;
                        i_make_visible=/*!bwGet(g_RuntimeBodyStateSettings,mod_command) **/
                            (mesh_count_index==param);
                        mesh_name=llList2String(s_KFTPelvisMeshes,mesh_count_index);
                    }
                    else if(MOD_SB_FKT_BUTT==mod_command)
                    {
                        g_CurrentFittedButState=param;
                        i_make_visible=/*!bwGet(g_RuntimeBodyStateSettings,mod_command) */
                            (mesh_count_index==param);
                        mesh_name=llList2String(s_KFTPelvisMeshes,mesh_count_index);
                    }
                    /* TODO: Handle overrides (PG, etc) since bitwise check
                    is removed */
                    debugLogic(i_make_visible);

                    if(llStringLength(mesh_name)>0)
                    {
                        dSay("YES2");
                        /* FIXME: PG nipple state briefly shows up mid-loop */
                        debugLogic(mesh_name);
                        list prim_names = xlBladeNameToPrimNames(mesh_name);
                        debugLogic(prim_names);
                        integer link_id=llList2Integer(g_LinkDB_l,
                            llListFindList(g_LinkDB_l ,prim_names)+1);
                        debugLogic(link_id);
                        debugLogic(llGetLinkName(link_id));
                        local_params +=[PRIM_LINK_TARGET,link_id];
                        // debugLogic(link_id);
                        list faces_l=[];
                        if(MOD_SB_FKT_NIPS==mod_command || KSB_PGNIPLS==mod_command){
                            dSay("YES3");
                            faces_l=xlGetFacesByBladeName(MESH_SK_NIPS);
                        }
                        else if(MOD_SB_FKT_VAGN==mod_command){
                            dSay("YES3");
                            faces_l=xlGetFacesByBladeName(API_CMD_VAG);
                        }
                        else if(MOD_SB_FKT_NIPH==mod_command){
                            dSay("YES3");
                            faces_l=xlGetFacesByBladeName(MESH_SK_NIPS);
                        }
                        else if(MOD_SB_FKT_BUTT==mod_command){
                            dSay("YES3");
                            faces_l=xlGetFacesByBladeName(API_CMD_VIRTUAL_BUTT);
                        }
                        else
                        {
                            dSay("NO3");
                            debugLogic(mod_command);
                        }
                        integer faces_count=xlListLen2MaxID(faces_l) + 1;
                        integer i2 = 0;
                        for(;i2 < faces_count;i2++)
                        {
                            dSay("YES4");
                            debugLogic(i2);
                            local_params+=[PRIM_COLOR,
                                llList2Integer(faces_l,i2),<1,1,1>,
                                    i_make_visible * g_Config_MaximumOpacity
                            ];
                        }
                        #ifdef DEBUG_FACE_SELECT
                        llOwnerSay("visible:"+(string)i_make_visible
                            +"\nFACES_COUNT:"+(string)faces_count
                            +"\nFACES:"+llList2CSV(faces_l)
                            +"\nTOGGLE_PART:"+(string)mod_command
                            +"\nMESH_NAME:"+mesh_name
                            +"\nPRIM_NAME:"+(string)prim_names);
                        #endif
                    }
                }
            }
            else if(API_CMD_NIPS==command)
            {
                /* Unfortunately repeated in BREASTS path but I'll
                look at that later
                */
                /* Manually hard-code this one for speed and simplicity*/
                debugLogic(i_make_visible);
                if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                {
                    list faces = xlGetFacesByBladeName(MESH_SK_NIPS);
                    debugLogic(faces);
                    // i_make_visible=!i_make_visible;
                    debugLogic(llList2Integer(g_LinkDB_l,
                                llListFindList(g_LinkDB_l, [llList2String(
                        s_FittedNipsMeshNames,g_CurrentFittedNipState)])+1));
                    debugLogic(llGetLinkName(mesh_id));
                    // if(i_make_visible){
                    // }
                    list snd_lvl_params = [
                    // alpha meshes
                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_NIP_0])+1),
                            PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                g_CurrentFittedNipAlpha < 1,
                            PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                g_CurrentFittedNipAlpha < 1,
                    // nipple meshes
                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_ETC])+1),
                            PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                i_make_visible * (g_CurrentFittedNipState == 1),
                            PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                i_make_visible * (g_CurrentFittedNipState == 1),
                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_NIP_1])+1),
                            PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                i_make_visible * (g_CurrentFittedNipState == 2),
                            PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                i_make_visible * (g_CurrentFittedNipState == 2),
                                /* TODO: handle MESH_FITTED_TORSO_NIP_A properly: reset to
                                 nipstate=1 and discard alpha state as per the original behaviour
                                 NOTE: Isn't that handled by the hud and the body just listens?
                                */
                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_NIP_A])+1),
                            PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                g_CurrentFittedNipAlpha > 0,
                            PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                g_CurrentFittedNipAlpha > 0
                    ];
                    /* Force hide the current nip layer */
                    local_params+=snd_lvl_params;
                }
            }
            else if(CMD_BODYCORE==mod_command_2)
            {
                list prim_names=xlBladeNameToPrimNames(command);
                #ifdef DEBUG_DATA
                    llOwnerSay("prim_names:{"+llList2CSV(prim_names)+"}");
                    llOwnerSay("prim_count="+(string)1);
                #endif
                    /* TODO: Be less nuclear and only fix the faces we asked for*/
                    /* TODO: inline as much as possible */
                    #ifdef DEBUG
                    integer target_link = llList2Integer(g_LinkDB_l,
                        llListFindList(g_LinkDB_l,prim_names)+1);
                    #endif
                    debugLogic(target_link);
                    debugLogic(llGetLinkName(target_link));
                    local_params+=[
                    PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,
                        llListFindList(g_LinkDB_l,prim_names)+1)
                    ];
                    list faces_l=xlGetFacesByBladeName(command);
                    integer faces_index=xlListLen2MaxID(faces_l);
                    #ifdef DEBUG_FACE_SELECT
                    llOwnerSay("Prim Count:"+(string)1);
                    llOwnerSay("Faces List 1:"+llList2CSV(faces_l));
                    llOwnerSay("Prim Names:"+llList2CSV(prim_names));
                    llOwnerSay("Faces Count:"+(string)(faces_index+1));
                    llOwnerSay("Prim Database:"+llList2CSV(g_LinkDB_l));
                    #endif
                for(;faces_index > -1; faces_index--)
                {
                    local_params+=[
                    PRIM_COLOR,llList2Integer(faces_l,faces_index),<1,1,1>,
                    // (i_make_visible ^ (API_CMD_VAG==command)) *
                    (i_make_visible) *
                    g_Config_MaximumOpacity
                    ];
                }
                if(API_CMD_BREASTS==command)
                {
                    ///* Manually hard-code this one for speed and simplicity*/
                    //if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                    //{
                    //  list faces = xlGetFacesByBladeName(MESH_SK_NIPS);
                    //  list snd_lvl_params = [
                    //      PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                    //              llListFindList(g_LinkDB_l, [llList2String(
                    //      s_FittedNipsMeshNames,g_CurrentFittedNipState)])+1),
                    //      PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                    //          i_make_visible,
                    //      PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                    //          i_make_visible
                    //  ];
                    //  /* Force hide the current nip layer */
                    //  local_params+=snd_lvl_params;
                    //}
                    /* Manually hard-code this one for speed and simplicity*/
                    debugLogic(i_make_visible);
                    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                    {
                        list faces = xlGetFacesByBladeName(MESH_SK_NIPS);
                        debugLogic(faces);
                        // i_make_visible=!i_make_visible;
                        debugLogic(llList2Integer(g_LinkDB_l,
                                    llListFindList(g_LinkDB_l, [llList2String(
                            s_FittedNipsMeshNames,g_CurrentFittedNipState)])+1));
                        debugLogic(llGetLinkName(mesh_id));
                        // if(i_make_visible){
                        // }
                        list snd_lvl_params = [
                        // alpha meshes
                        PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_NIP_0])+1),
                                PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipAlpha < 1),
                                PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipAlpha < 1),
                        // nipple meshes
                        PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_ETC])+1),
                                PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipState == 1),
                                PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipState == 1),
                        PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_NIP_1])+1),
                                PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipState == 2),
                                PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipState == 2),
                                    /* TODO: handle MESH_FITTED_TORSO_NIP_A properly: reset to
                                     nipstate=1 and discard alpha state as per the original behaviour
                                    */
                        PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l, llListFindList(g_LinkDB_l,[MESH_FITTED_TORSO_NIP_A])+1),
                                PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipAlpha > 0),
                                PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                                    i_make_visible * (g_CurrentFittedNipAlpha > 0)
                        ];
                        /* Force hide the current nip layer */
                        local_params+=snd_lvl_params;
                    }
                }
                //else if(API_CMD_VAG==command)
                //{
                //    /* Manually hard-code this one for speed and simplicity*/
                //    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                //    {
                //        list faces = xlGetFacesByBladeName(MESH_SK_VAGOO);
                //        list snd_lvl_params = [
                //            PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                //                    llListFindList(g_LinkDB_l, [llList2String(
                //            s_FittedNipsMeshNames,g_CurrentFittedNipState)])+1),
                //            PRIM_COLOR, llList2Integer(faces,1), <1,1,1>,
                //                i_make_visible,
                //            PRIM_COLOR, llList2Integer(faces,0), <1,1,1>,
                //                i_make_visible
                //        ];
                //        /* Force hide the current nip layer */
                //        local_params+=snd_lvl_params;
                //    }
                //}
                /* TODO: Finish this */
                //if(API_CMD_VIRTUAL_BUTT==command)
                //{
                //    /* Note: Will not hide properly if hud state does not match
                //    the mesh state */
                //    /* Manually hard-code this one for speed and simplicity*/
                //    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                //    {
                //        list nip_faces = xlGetFacesByBladeName(API_CMD_NIPS);
                //        list nip_params = [
                //            PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                //                    llListFindList(g_LinkDB_l, [llList2String(
                //            s_FittedNipsMeshNames,g_CurrentFittedNipState)])+1),
                //            PRIM_COLOR, llList2Integer(nip_faces,1), <1,1,1>,
                //                i_make_visible,
                //            PRIM_COLOR, llList2Integer(nip_faces,0), <1,1,1>,
                //                i_make_visible
                //        ];
                //        /* Force hide the current nip layer */
                //        local_params+=nip_params;
                //    }
                //}
                //if(API_CMD_PELVIS==command)
                //{
                //    /* Manually hard-code this one for speed and simplicity*/
                //    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
                //    {
                //        list nip_faces = xlGetFacesByBladeName(API_CMD_VAG);
                //        list nip_params = [
                //            PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                //                    llListFindList(g_LinkDB_l, [llList2String(
                //            s_FittedNipsMeshNames,g_CurrentFittedNipState)])+1),
                //            PRIM_COLOR, llList2Integer(nip_faces,1), <1,1,1>,
                //                i_make_visible,
                //            PRIM_COLOR, llList2Integer(nip_faces,0), <1,1,1>,
                //                i_make_visible
                //        ];
                //        /* Force hide the current nip layer */
                //        local_params+=nip_params;
                //    }
                //}
            }
        }
    }
    /* Send params to prim now */
    // if(send_params){
        // #ifdef DEBUG_PARAMS
        // #endif
        #ifdef DEBUG_COMMAND
        llOwnerSay("===== Setting global params =====");
        #endif
        if(send_params)
        {
            xlSetLinkPrimitiveParamsFast(LINK_ROOT,local_params);
        }
        local_params=[];
    // }
    #ifdef DEBUG_COMMAND
    llOwnerSay("=================================");
    #endif
}
redeform(){
    if(g_HasAnimPerms)
    {
        // llOwnerSay("Redeform");
        llStopAnimation(g_AnimUndeform);
        llStartAnimation(g_AnimDeform);
    }
}
resetHands()
{
    if(g_HasAnimPerms){
        llStopAnimation("Kem-hand-L-fist");
        llStopAnimation("Kem-hand-L-hold");
        llStopAnimation("Kem-hand-L-horns");
        llStopAnimation("Kem-hand-L-point");
        llStopAnimation("Kem-hand-R-fist");
        llStopAnimation("Kem-hand-R-hold");
        llStopAnimation("Kem-hand-R-horns");
        llStopAnimation("Kem-hand-R-point");
        llStartAnimation("Kem-hand-R-relax");
        llStartAnimation("Kem-hand-L-relax");
        redeform();
    }
}
reset(){
    // TODO: Respect PG mode. Stock body does this.
    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
    {
        // This is ugly as hell but it will reset it for real.
        integer i;
        list params;
        for(i=0;i<llGetListLength(s_KFTPelvisMeshes);i++)
        {
            string mesh_name = llList2String(s_KFTPelvisMeshes,i);
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer link_id=llList2Integer(g_LinkDB_l,
                llListFindList(g_LinkDB_l ,prim_names)+1);
            params+=[PRIM_LINK_TARGET,link_id];
            // list faces = xlGetFacesByBladeName(API_CMD_VIRTUAL_BUTT);
            // integer f;
            // for(f=0;f<llGetListLength(faces);f++)
            {
                // params +=[PRIM_COLOR,llList2Integer(faces,f),<1,1,1>,0.0];
                params +=[PRIM_COLOR,ALL_SIDES,<1,1,1>,0.0];
                // llOwnerSay(llGetLinkName(link_id)+","+llList2String(faces,f));
            }
        }
        llSetLinkPrimitiveParamsFast(LINK_ROOT, params);
    }
    g_LastCommand_s=KM_HUD_RESET_CMD;
    xlProcessCommand(TRUE);
    if(bwGet(g_RuntimeBodyStateSettings,FKT_PRESENT))
    {
        // llSleep(0.1);
        g_LastCommand_s = ":nipalpha:"+(string)g_DefaultFittedNipAlpha;
        xlProcessCommand(TRUE);
        // g_LastCommand_s = ":vagState:"+(string)g_DefaultFittedVagState;
        // xlProcessCommand(TRUE);
        // g_LastCommand_s = ":buttState:"+(string)g_DefaultFittedButState;
        // xlProcessCommand(TRUE);
        g_LastCommand_s = ":setnip:"+(string)g_DefaultFittedNipState;
        xlProcessCommand(TRUE);
        //g_LastCommand_s = ":nipOvrd:0" /* TODO: Implement Nipple Override */;
        //xlProcessCommand(TRUE);
    }
    resetHands();
}
detectLinkSetMods()
{
    #ifdef DEBUG_ENTIRE_BODY_ALPHA
    string texture=llGetInventoryName(INVENTORY_TEXTURE,0);
    integer retexture=texture !="";
    list prim_params_to_apply=[];
    #endif
    integer part=llGetNumberOfPrims();
    integer found_fitted_torso = FALSE;
    for (;part > 0;--part){
        string name=llGetLinkName(part);
        #ifdef DEBUG_TEXT
        llSetText("\n \n \n \n \n \n["+(string)llGetFreeMemory()
            +"]Processing "+name+"...",<0,0,0>,1.0);
        #endif
        if(!found_fitted_torso){
            if(name == API_CMD_FITTED_TORSO){
                /* Shortcut if previously renamed */
                found_fitted_torso = TRUE;
                name=MESH_FITTED_TORSO;
            }
            else if(llSubStringIndex(name, "Kemono")!=-1 &&
                llSubStringIndex(name, "Torso")!=-1 &&
                (llSubStringIndex(name, "Petite")!=-1 ||
                llSubStringIndex(name, "Busty")!=-1)){
                // debugLogic(llSubStringIndex(name, "Kemono"));
                // debugLogic(llSubStringIndex(name, "Torso"));
                // debugLogic(llSubStringIndex(name, "Busty"));
                // debugLogic(llSubStringIndex(name, "Petite"));
                // llOwnerSay("Found Fitted Torso: " + name + " on link ID:" + (string)part);
                found_fitted_torso = TRUE;
                llSetLinkPrimitiveParams(part, [PRIM_NAME,API_CMD_FITTED_TORSO]);
                name=MESH_FITTED_TORSO;
            }
        }
        if(llListFindList(g_supported_meshes,[name])!=-1){
            #ifdef DEBUG_ENTIRE_BODY_ALPHA
            prim_params_to_apply +=[
            PRIM_LINK_TARGET,part,PRIM_COLOR,ALL_SIDES,<1,1,1>,0.0
            ];
            if(retexture){
                prim_params_to_apply+=[
                PRIM_TEXTURE,ALL_SIDES,texture,<1,1,0>,<0,0,0>,0.0
                ];
            }
            #endif
            g_LinkDB_l+=[name,part];
        }
    }
    if(found_fitted_torso){
        /* NOTE: This is only needed when not combining the Kemono body with the Fitted torso, which I do not have fully tested.
        // xlProcessCommand("hide:neck:shoulderLR:shoulderLL:shoulderUR:shoulderUL:collar:chest:breast:ribs:abs:belly:pelvis:hipR:hipL:thighUR:thighUL:thighLR:thighLL");
        */
        bwSet(g_RuntimeBodyStateSettings,FKT_PRESENT);
    }
    #ifdef DEBUG_ENTIRE_BODY_ALPHA
    llSetLinkPrimitiveParamsFast(LINK_ROOT,prim_params_to_apply);
    #endif
    #ifdef DEBUG_SELF_TEST
    //llSetText("[UNIT SELF-TEST]",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
    xlProcessCommand("hide:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
        +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
        +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
        +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
        +"elbowR:armLL:armLR:wristL:wristR:handL:handR",TRUE);
    llSleep(0.25);
    xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
        +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
        +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
        +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
        +"elbowR:armLL:armLR:wristL:wristR:handL:handR",TRUE);
    llSleep(0.25);
    list selftest=["neck","shoulderUL","shoulderUR","collar","shoulderLL",
    "shoulderLR","armUL","armUR","chest","breast","elbowL","elbowR",
    "ribs","armLL","armLR","abs","wristL","wristR","belly","handL","handR",
    "pelvis","hipL","hipR","thighUL","thighUR","thighLL",
    "thighLR","kneeL","kneeR","calfL","calfR","shinUL","shinUR",
    "shinLL","shinLR","ankleL","ankleR","footL","footR"];
    integer id = 0;
    integer len = xlListLen2MaxID(selftest)+1;
    for(;id < len;++id){
        xlProcessCommand("hide:"+llList2String(selftest,id),TRUE);
        // llSleep(0.0625);
    }
    for(;id>-1;id--){
        xlProcessCommand("show:"+llList2String(selftest,id),TRUE);
        // llSleep(0.0625);
    }
    #endif
    #ifdef USE_DEFORM_ANIMS
        g_AnimDeform=llGetInventoryName(INVENTORY_ANIMATION,0);
        g_AnimUndeform=llGetInventoryName(INVENTORY_ANIMATION,1);
        #ifdef DEBUG_DATA
            llOwnerSay("Link database: "+llList2CSV(g_LinkDB_l));
            llOwnerSay("Deform:"+g_AnimDeform);
            llOwnerSay("Undeform:"+g_AnimUndeform);
        #endif
    #endif
    list data = llCSV2List(llGetObjectDesc());
    human_mode = llList2Integer(data,0);
    if(llListFindList(g_LinkDB_l,[MESH_LEG_LEFT_ANIMAL]) == -1 && llListFindList(g_LinkDB_l,[MESH_LEG_RIGHT_ANIMAL]) == -1){
        // Animal legs are missing
        g_LastCommand_s="Hlegs";
        xlProcessCommandWrapper();
        llOwnerSay("Adjusted for missing animal legs");
    }
    else if(llListFindList(g_LinkDB_l,[MESH_LEG_LEFT_HUMAN]) == -1 && llListFindList(g_LinkDB_l,[MESH_LEG_RIGHT_HUMAN]) == -1){
        // Human Legs are missing
        g_LastCommand_s="Flegs";
        xlProcessCommandWrapper();
        llOwnerSay("Adjusted for missing human legs");
    }
}
default {
    #ifdef DEBUG_FACE_TOUCH
    touch_start(integer total_number){
        key tk=llDetectedKey(0);
        if(tk!=g_Owner_k) return;
        llRegionSayTo(tk,0,
            "ID:"+(string)llDetectedLinkNumber(0)+";prim_name=\""+
            llGetLinkName(llDetectedLinkNumber(0))+"\";face_list=["
            +(string)llDetectedTouchFace(0)+"];break;");
    }
    #endif
    changed(integer change){
        if(change & CHANGED_OWNER){
            llResetScript();
        }
        else if(change & CHANGED_LINK){
            llOwnerSay("Linkset changed, resetting...");
            detectLinkSetMods();
        }
    }
    state_entry(){
        if(llGetObjectName()=="[Xenhat] Enhanced Kemono Updater"){
            llSetObjectDesc((string)(human_mode) + "," + g_internal_version_s);
           state dead;
        }
        dSay("Starting up...");
    // llOwnerSay("Resetting... O3O!!!");
string self=llGetScriptName();string basename=self;string tail = "MISSING_VERSION";if(llSubStringIndex(self," ") >= 0){integer start=2;
tail=llGetSubString(self,llStringLength(self) - start,-1);while(llGetSubString(tail,0,0)!=" ")
{start++;tail=llGetSubString(self,llStringLength(self) - start,-1);}if((integer)tail > 0){
basename=llGetSubString(self,0,-llStringLength(tail) - 1);}}integer n=llGetInventoryNumber(INVENTORY_SCRIPT);
while(n-- > 0){string item=llGetInventoryName(INVENTORY_SCRIPT,n);
if(item != self && 0 == llSubStringIndex(item,basename)){llRemoveInventory(item);llOwnerSay("Upgraded to "+ tail);}}
        #ifdef DEBUG_TEXT
        llScriptProfiler(PROFILE_SCRIPT_MEMORY);
        #endif
        g_Owner_k=llGetOwner();
        #ifdef GITHUB_UPDATER
        g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
            +g_internal_repo_s
            +"/releases/latest?access_token="
            +"603ee815cda6fb45fcc16876effbda017f158bef",
            [HTTP_BODY_MAXLENGTH,16384],"");
        #endif
        detectLinkSetMods();
        if(llGetAttached()){
            llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
        }
        llSetText("",ZERO_VECTOR,0.0);
        llListen(KEMONO_COM_CH,"","","");
        #ifdef DEBUG_SELF_TEST
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
            +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
            +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
            +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
            +"elbowR:armLL:armLR:wristL:wristR:handL:handR",TRUE);
        llRegionSayTo(g_Owner_k,KEMONO_COM_CH,"show:neck:collar:shoulderUL:shoulderUR:"
            +"shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
            +"hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
            +"shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
            +"armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        #endif

        dSay("Ready.");
    }
    listen(integer channel,string name,key id,string message){
        if(id==llGetKey())
        #ifdef DEBUG_MESSAGE_FROM_SELF
        {
            llOwnerSay("Message came from self, what?");
        #endif
            return;
        #ifdef DEBUG_MESSAGE_FROM_SELF
        }
        #endif
        #ifdef BENCHMARK
            llResetTime();
        #endif
        key object_owner_k=llGetOwnerKey(id);
        #ifdef DEBUG_LISTEN
            string oname = llGetObjectName();
            llSetObjectName(llGetSubString((string)llGetKey(),0, 6) + " Debug");
            llOwnerSay("Time:"+(string)llGetTimestamp());
                string knp="["+(string)id+"]"+"{"+llKey2Name(id)+"}("
                +llKey2Name(object_owner_k)+" ";
                llOwnerSay(knp+"input ["+message+"]");
        #else
            #ifdef DEBUG_LISTEN_LITE
                llOwnerSay("["+llKey2Name(id)+"]: " +message);
            #endif
        #endif
        
        /*
        ------------------ AUTH SYSTEM PRIMER --------------------------
            Because llGetOwnerKey() returns either returns null key
             or the sender object's uuid (instead of its owner's) when
             checking a message that has been sent by an object which
             has been detached already and is no longer existing on
             the sim (98% of the cases),
             == The traditional owner check cannot be performed. ==
             For this reason, the 'auth list' keeps track of the
             objects who 'add' themselves through the api to
             determine the owner of a detaching object (since the
             regular way to perform this check will fail).
             Consequently, we use the aforementioned 'auth list' to
             perform the required authentication check when receiving
             an "invalid" owner key by looking for the object's key
             within it.
             We then honor any 'remove' command by expunging the list
             of the object's key. This does not however prevent further
             commands from being excuted, as the auth list is only
             used on detach. This behaviour is consistent with the
             stock script and is therefore preserved for the time being.
        -----------------------------------------------------------------
        */
        if(object_owner_k != g_Owner_k)
        {
            // Most likely case, make handling other resident's attachments
            // as impactless as we can.
            if(object_owner_k != id){
                // someboey else's stuff
                return;
            }
            #ifdef DEBUG_AUTH
            llOwnerSay("Bogus Owner Key for '"+name+"'");
            #endif
            if(llListFindList(g_AttmntAuthedKeys_l,[id]) == -1){
                #ifdef DEBUG_AUTH
                llOwnerSay("Ignoring unauthed [" + (string)id + "]" + llKey2Name(id));
                #endif
                return;
            }
            /* probably a detaching object */

        }
        else /* if(object_owner_k == g_Owner_k) */
        {
            integer separatorIndex=llSubStringIndex(g_LastCommand_s,":");
            if(separatorIndex < 0) separatorIndex = 0;
            #ifdef DEBUG_AUTH
            llOwnerSay("Owner for [" +llKey2Name(id)+ "]is correct!");
            #endif
            string first_command = llGetSubString(g_LastCommand_s, 0, separatorIndex-1);
            // TODO: Allow chaining (read kemono manual for allowed cases?)
            if(first_command=="add")
            { /* And add if not in the auth list */
                #ifdef DEBUG_AUTH
                llOwnerSay("Detected Add command!");
                #endif
                if(llGetFreeMemory() > 2048){
                    if (id != g_Owner_k)
                    {
                        if(llListFindList(g_AttmntAuthedKeys_l,[id])==-1)
                        {
                            g_AttmntAuthedKeys_l +=[id];
                            #ifdef DEBUG_AUTH
                            llOwnerSay("Adding [" + (string)id + "] (" + llKey2Name(id) + ") to auth list");
                            #endif
                            // return;
                        }
                    }
                }
                #ifdef DEBUG_AUTH
                else
                {
                    llOwnerSay("Not enough memory to add!");
                }
                #endif
            }
        }
        g_LastCommand_s = message;
        g_Last_k = id;
        xlProcessCommandWrapper();
        #ifdef DEBUG_LISTEN
        llOwnerSay("End of listener processing for '" + message + "'");
        llSleep(1);
        #endif
        #ifdef DEBUG_LISTEN
        llSetObjectName(oname);
        #endif
        #ifdef BENCHMARK
            llOwnerSay("Took " + (string)llGetTime() + " (endof listen)");
        #endif
    }
    on_rez(integer p){
    /*Wait a few seconds in case we're still rezzing*/
        llSleep(3);
        #ifdef GITHUB_UPDATER
        g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
            +g_internal_repo_s
            +"/releases/latest?access_token="
            +"603ee815cda6fb45fcc16876effbda017f158bef",
            [HTTP_BODY_MAXLENGTH,16384],"");
        #endif
    }
#ifdef USE_DEFORM_ANIMS
    attach(key id){
        if(llGetObjectName()=="[Xenhat] Enhanced Kemono Updater"){return;}
        /* Deform on detach, unlike the stock body. This assumes permissions
        *  are granted, which happens on rez or startup if attached.
        *  Needs to be processed as fast as possible to make it before the
        *  object is pruned from the Current Outfit Folder otherwise
        *  it won't fire.
        */
        if(id==NULL_KEY){
            #ifdef USE_DEFORM_ANIMS_FOR_DETACH
            llStartAnimation(g_AnimUndeform);
            llSleep(0.1);
            llStopAnimation(g_AnimUndeform);
            #endif
        }
        else{
            llStopAnimation(g_AnimUndeform);
            llSleep(0.1);
            llStartAnimation(g_AnimDeform);
        }
    }
#endif
    run_time_permissions(integer perm){
        // What?
        //if(!g_HasAnimPerms){
        //    resetHands();
        //}
        g_HasAnimPerms=TRUE;
        #ifdef RESET_ON_PERMS
        /* Send a "reset" message to forcefully trigger clothing autohiders */
        llRegionSayTo(g_Owner_k,KEMONO_COM_CH,"show:neck:collar:shoulderUL:shoulderUR:"
            +"shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
            +"hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
            +"shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
            +"armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        #endif
        llSetTimerEvent(5);
    }
    timer(){
#ifdef USE_DEFORM_ANIMS
        if(!g_HasAnimPerms){
            llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
        }
        else{
            #ifdef SMART_DEFORM
            if(
                undeform_instead ||
                llGetAgentInfo(g_Owner_k)&AGENT_SITTING){
                    llStopAnimation(g_AnimDeform);
                    llStartAnimation(g_AnimUndeform);
            }
            else{
            #endif
            redeform();
            #ifdef SMART_DEFORM
            }
            #endif
        }
        #endif
        #ifdef DEBUG_TEXT
        string text;
        text="[DEBUG]"+text;
        text+="\nU: "+(string)llGetUsedMemory()+"["+(string)llGetSPMaxMemory()
        +"]/"+(string)llGetMemoryLimit()+"B";
        #ifdef DEBUG_FACE_SELECT
        text+="\nPG_v:"+(string)g_TogglingPGMeshes;
        #endif
        text+="\n"+(string)(xlListLen2MaxID(g_AttmntAuthedKeys_l)+1)
        +" Keys\n \n ";
        text+="\n \n \n \n \n \n ";
        llSetText(text+"\n \n \n \n ",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        #endif
    }
    #ifdef DEBUG_LISTEN
    link_message(integer sender_num, integer num, string message, key id){
        llOwnerSay("LINK MESSAGE["+(string)id+"]: '" + message + "'");
    }
    #endif
    #ifdef GITHUB_UPDATER
    http_response(key request_id,integer status,list metadata,string body)
    {
        if(request_id !=g_internal_httprid_k) return;// exit if unknown
        g_internal_httprid_k=NULL_KEY;
        string new_version_s=llJsonGetValue(body,["tag_name"]);
        if(new_version_s==g_internal_version_s) return;
        list cur_version_l=llParseString2List(g_internal_version_s,["."],[""]);
        list new_version_l=llParseString2List(new_version_s,["."],[""]);
        // Major
        if(llList2Integer(new_version_l,0) > llList2Integer(cur_version_l,0)){
            jump update;
        }
        // Minor
        else if(llList2Integer(new_version_l,1) >
            llList2Integer(cur_version_l,1)){
            jump update;
        }
        // Patch (bugfix)
        else if(llList2Integer(new_version_l,2) >
            llList2Integer(cur_version_l,2)){
            jump update;
        }
        return;
        @update;
        string update_title=llJsonGetValue(body,["name"]);
        if(update_title=="﷕")update_title="";
        string update_description=llJsonGetValue(body,["body"]);
        if(update_description=="﷕"){
            update_description="";
        }
        string changelog = update_description;
        update_description="\nAn update is avaible! ("+g_internal_version_s +"🡂"+new_version_s+")\n\""
            +update_title+"\"\n"+changelog+"\n";
        string link = "\nYour new script:\n[https://raw.githubusercontent.com/"
        +g_internal_repo_s+"/"+new_version_s+"/compiled/"+compiled_name+" "
        +script_name+".lsl]";
        llOwnerSay(update_description+link);
        if(llStringLength(update_description) > (512 - llStringLength(link))){
        update_description="Too many changes, see ["+"https://github.com/"+g_internal_repo_s
        +"/compare/"+g_internal_version_s+"..."+new_version_s+" Changes for "
        +g_internal_version_s+"🡂"+new_version_s+"]";
        }
        llDialog(g_Owner_k,update_description+link,[],-1);
    }
    #endif
}
state dead
{
    state_entry()
    {
        // In updater, do nothing.
    }
}
