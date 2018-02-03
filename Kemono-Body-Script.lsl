/* <- Enlarge window so you see this on only one line for better visibility ->
*
* Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life
* Original creation date: 6/06/2017 22:52:37
* The latest version of this script is located at:
* https://github.com/XenHat/Kemono-Body-Script/blob/master/xenhat.kemono.body.lsl
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
* You MUST:
*  Include License
*  Include Original
*  State Changes
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
float g_Config_MaximumOpacity=1.00; // 0.8 // for goo
/*-------------------------------------------------------------------------- */
/* NO USER-EDITABLE VALUES BELOW THIS LINE */
#define g_internal_version_s "0.3.7" /* NOTE: Only bump on bugfix ok?*/
/* Debugging */
// #define DEBUG
// #define DEBUG_SELF_TEST
// #define DEBUG_TEXT
// #define DEBUG_AUTH
// #define DEBUG_ENTIRE_BODY_ALPHA
// #define DEBUG_LISTEN
// #define DEBUG_LISTEN_ALL
// #define DEBUG_COMMAND
// #define DEBUG_DATA
// #define DEBUG_PARAMS
// #define DEBUG_FACE_SELECT
// #define DEBUG_FACE_TOUCH
// #define DEBUG_FUNCTIONS
/* End of debug defines */
/* Normal Features that should be enabled */
#define GITHUB_UPDATER
#define PROCESS_LEGS_COMMANDS
// #define PRINT_UNHANDLED_COMMANDS
#define HOVER_TEXT_COLOR <0.925,0.925,0.925>
#define HOVER_TEXT_ALPHA 0.75
#ifdef DEBUG_PARAMS
#define xlSetLinkPrimitiveParamsFast(a,b) llOwnerSay("PARAMS:"+llList2CSV(b));\
llSetLinkPrimitiveParamsFast(a,b)
#else
#define xlSetLinkPrimitiveParamsFast(a,b) llSetLinkPrimitiveParamsFast(a,b)
#endif
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
#define BLADE_ABS "abs"
#define BLADE_ANKLE_L "ankleL"
#define BLADE_ANKLE_R "ankleR"
#define BLADE_ARM_L_L "armLL"
#define BLADE_ARM_L_R "armLR"
#define BLADE_ARM_U_L "armUL"
#define BLADE_ARM_U_R "armUR"
#define BLADE_BELLY "belly"
#define BLADE_BREASTS "breast"
#define BLADE_CALF_L "calfL"
#define BLADE_CALF_R "calfR"
#define BLADE_CHEST "chest"
#define BLADE_COLLAR "collar"
#define BLADE_ELBOW_L "elbowL"
#define BLADE_ELBOW_R "elbowR"
#define BLADE_FITTED_TORSO "Fitted Torso"
#define BLADE_FOOT_L "footL"
#define BLADE_FOOT_R "footR"
#define BLADE_HIP_L "hipL"
#define BLADE_HIP_R "hipR"
#define BLADE_KNEE_L "kneeL"
#define BLADE_KNEE_R "kneeR"
#define BLADE_NIPS "nips"
#define BLADE_PELVIS "pelvis"
#define BLADE_RIBS "ribs"
#define BLADE_SHIN_L_L "shinLL"
#define BLADE_SHIN_L_R "shinLR"
#define BLADE_SHIN_U_L "shinUL"
#define BLADE_SHIN_U_R "shinUR"
#define BLADE_SHOULDER_L_L "shoulderLL"
#define BLADE_SHOULDER_L_R "shoulderLR"
#define BLADE_SHOULDER_U_L "shoulderUL"
#define BLADE_SHOULDER_U_R "shoulderUR"
#define BLADE_THIGH_L_L "thighLL"
#define BLADE_THIGH_L_R "thighLR"
#define BLADE_THIGH_U_L "thighUL"
#define BLADE_THIGH_U_R "thighUR"
#define BLADE_VAG "vagoo"
#define BLADE_VIRTUAL_BUTT "butt"
#define BLADE_WRIST_L "wristL"
#define BLADE_WRIST_R "wristR"
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
#define s_FittedNipsMeshNames [\
MESH_FITTED_TORSO_NIP_0,\
MESH_FITTED_TORSO_ETC,\
MESH_FITTED_TORSO_NIP_1,\
MESH_FITTED_TORSO_NIP_A\
]
#define s_KFTPelvisMeshes [\
"BitState0",\
"BitState1",\
"BitState2",\
"BitState3"\
]
#define FKT_PRESENT 1
/* PG States */
#define KSB_PGVAGOO 2
#define KSB_PGNIPLS 4
/* Flags for blade sync purposes*/
#define FKT_FHIDE_B 8
#define FKT_FHIDE_N 16
#define FKT_FHIDE_V 32
/* Some shorthand operators are not allowed in LSL, so let's do some hackery
*    usage:
*        a=variable/set
*        b=bit (define, see above)
*/
#define chgBit(a,b,c) a=(a & (~b)) | (b * c);
#define clrBit(a,b) a=(a & (~b))
#define getBit(a,b) (!!(a & b))
#define setBit(a,b) a=(a | b)
#define togBit(a,b) a ^=1 << b
#define xlListLen2MaxID(a) ((a!=[])-1)
/* === Updater settings === */
#define compiled_name "xenhat.kemono.body.lsl"
#define g_internal_repo_s "XenHat/"+script_name
#define script_name "Kemono-Body-Script"
/* === Runtime settings and values === */
integer g_CurrentFittedButState=1;
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedVagState=1;
integer g_HasAnimPerms=FALSE;
integer g_RuntimeBodyStateSettings;
integer g_TogglingPGMeshes=FALSE;
integer human_mode=TRUE; /* Prefer when available*/
#ifdef GITHUB_UPDATER
key g_internal_httprid_k=NULL_KEY;
#endif
key g_Owner_k;
list g_LinkDB_l=[];
list g_RemConfirmKeys_l;
/* Overridable deform animation */
string g_AnimDeform;
string g_AnimUndeform;
/* === User Functions === */
list xlGetFacesByBladeName(string name){
    if(name==BLADE_ABS) return [6,7];
    if(name==BLADE_ANKLE_L){
        if(human_mode) return [1];
        return [5];
    }
    if(name==BLADE_ANKLE_R){
        if(human_mode)
            return [1];
        return [5];
    }
    if(name==BLADE_ARM_L_L) return [7];
    if(name==BLADE_ARM_L_R) return [2];
    if(name==BLADE_ARM_U_L) return [0];
    if(name==BLADE_ARM_U_R) return [6];
    if(name==BLADE_BELLY) return [2,3];
    if(name==MESH_BODY) return [0];
    if(name==BLADE_BREASTS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [2,3];
        return [2,5];
    }
    if(name==BLADE_CALF_L){
        if(human_mode)
            return [4];
        return [2];
    }
    if(name==BLADE_CALF_R){
        if(human_mode)
            return [4];
        return [2];
    }
    if(name==BLADE_CHEST){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1];
        if(human_mode)
            return [0,4];
        return [0,4];
    }
    if(name==BLADE_COLLAR){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [6,7];
        return [1,6];
    }
    if(name==BLADE_ELBOW_L) return [4];
    if(name==BLADE_ELBOW_R) return [5];
    if(name==BLADE_FOOT_L) return [0];
    if(name==BLADE_FOOT_R) return [0];
    if(name==BLADE_HIP_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [6];
    }
    if(name==BLADE_HIP_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [4];
        return [5];
    }
    if(name==BLADE_KNEE_L){
        if(human_mode)
            return [5];
        return [1];
    }
    if(name==BLADE_KNEE_R){
        if(human_mode)
            return [5];
        return [1];
    }
    if(name==MESH_HAND_LEFT)
        return [-1];
    if(name==MESH_HAND_RIGHT)
        return [-1];
    if(name==MESH_NECK){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1];
        return [2,5];
    }
    if(name==BLADE_NIPS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            /* Note: Before changing this again, create a different way of
            *  handling the request that doesn't match.
            * This is configured properly for the whole Fitted Torso chest mesh
            */
            return [0,1];
        return [2,3];
    }
    if(name==BLADE_PELVIS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1,2,3];
        return [0,1];
    }
    if(name==BLADE_RIBS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [4,5];
        return [1,3];
    }
    if(name==BLADE_SHIN_L_L){
        if(human_mode)
            return [2];
        return [4];
    }
    if(name==BLADE_SHIN_L_R){
        if(human_mode)
            return [2];
        return [4];
    }
    if(name==BLADE_SHIN_U_L)
        return [3];
    if(name==BLADE_SHIN_U_R)
        return [3];
    if(name==BLADE_SHOULDER_L_L)
        return [3];
    if(name==BLADE_SHOULDER_L_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [2];
        return [0];
    }
    if(name==BLADE_SHOULDER_U_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [7];
    }
    if(name==BLADE_SHOULDER_U_R)
        return [4];
    if(name==BLADE_THIGH_L_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(human_mode)
                return [1];
            return [7];
        }
        return [6];
    }
    if(name==BLADE_THIGH_L_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            if(human_mode)
                return [0];
            return [6];
        }
        return [6];
    }
    if(name==BLADE_THIGH_U_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [7];
    }
    if(name==BLADE_THIGH_U_R) return [4];
    if(name==BLADE_VAG){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
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
    if(name==BLADE_VIRTUAL_BUTT){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            /* Reminder: On the Fitted Torso, this is the upper hip mesh half.
            *  The bottom hip mesh half is controlled independently using
            *  setbutt
            */
            #ifdef DEBUG_COMMAND
            llOwnerSay("uuuuuuuuu["+(string)g_TogglingPGMeshes+"]");
            #endif
            if(g_TogglingPGMeshes)
                return [0,1,2,3,4,5];
            return [2,3,4,5];
        }
        return [];
    }
    if(name==BLADE_WRIST_L) return [3];
    if(name==BLADE_WRIST_R) return [1];
    #ifdef DEBUG_FUNCTIONS
    llOwnerSay("UNIMPLEMENTED:"+name+"!");
    #endif
    return [];
}
list xlBladeNameToPrimNames(string name){
    /* TODO Can't we return the link number directly (using less than 512 bytes
    *  of code!) without an additional function call?
    */
    #ifdef DEBUG_FACE_SELECT
    llOwnerSay("xlBladeNameToPrimNames("+name+")");
    #endif
    if(name==BLADE_ARM_L_L) return [MESH_ARMS];
    else if(name==BLADE_ARM_L_R) return [MESH_ARMS];
    else if(name==BLADE_ARM_U_L) return [MESH_ARMS];
    else if(name==BLADE_ARM_U_R) return [MESH_ARMS];
    else if(name==BLADE_ELBOW_L) return [MESH_ARMS];
    else if(name==BLADE_ELBOW_R) return [MESH_ARMS];
    else if(name==BLADE_WRIST_L) return [MESH_ARMS];
    else if(name==BLADE_WRIST_R) return [MESH_ARMS];
    else if(name==BLADE_RIBS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==BLADE_ABS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==MESH_BODY){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==BLADE_BREASTS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==BLADE_CHEST){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_CHEST];
        return [MESH_BODY];
    }
    else if(name==BLADE_COLLAR){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==MESH_HAND_LEFT) return [MESH_HAND_LEFT];
    else if(name==MESH_HAND_RIGHT) return [MESH_HAND_RIGHT];
    else if(name==BLADE_HIP_L || name==BLADE_HIP_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        return [MESH_HIPS];
    }
    else if(name==MESH_NECK){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==BLADE_PELVIS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        return [MESH_HIPS];
    }
    else if(name==BLADE_KNEE_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_FOOT_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_ANKLE_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_SHIN_U_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_CALF_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_SHIN_L_R){
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_CALF_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==BLADE_ANKLE_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==BLADE_FOOT_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==BLADE_KNEE_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==BLADE_SHIN_L_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==BLADE_SHIN_U_L){
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
    else if(name==BLADE_SHOULDER_L_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==BLADE_SHOULDER_L_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==BLADE_SHOULDER_U_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==BLADE_SHOULDER_U_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO];
        return [MESH_NECK];
    }
    else if(name==BLADE_THIGH_U_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_ETC];
        return [MESH_HIPS];
    }
    else if(name==BLADE_THIGH_U_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_ETC];
        return [MESH_HIPS];
    }
    else if(name==BLADE_BELLY){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [MESH_FITTED_TORSO_ETC];
        return [MESH_HIPS];
    }
    else if(name==BLADE_NIPS){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [llList2String(s_FittedNipsMeshNames,
                        g_CurrentFittedNipState)];
        return [MESH_PG_LAYER];
    }
    else if(name==BLADE_VAG){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            if(g_TogglingPGMeshes)
                return [llList2String(s_KFTPelvisMeshes,0)];
            return [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        return [MESH_PG_LAYER];
    }
    else if(name==BLADE_THIGH_L_R){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            if(human_mode)
                return [MESH_FITTED_TORSO_HLEGS];
            return [MESH_FITTED_TORSO_ETC];
        if(human_mode)
            return [MESH_LEG_RIGHT_HUMAN];
        return [MESH_LEG_RIGHT_ANIMAL];
    }
    else if(name==BLADE_THIGH_L_L){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            if(human_mode)
                return [MESH_FITTED_TORSO_HLEGS];
            return [MESH_FITTED_TORSO_ETC];
        if(human_mode)
            return [MESH_LEG_LEFT_HUMAN];
        return [MESH_LEG_LEFT_ANIMAL];
    }
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
list xlSetGenitals(integer pTogglePart){
    #ifdef DEBUG_FUNCTIONS
    llOwnerSay("xlSetGenitals");
    #endif
    list params;
    integer meshes_count=0;
    if(FKT_FHIDE_N==pTogglePart)
        meshes_count=xlListLen2MaxID(s_FittedNipsMeshNames);
    else
        meshes_count=xlListLen2MaxID(s_KFTPelvisMeshes);
    integer visible=FALSE;
    string mesh_name="";
    for(;meshes_count > -1;meshes_count--){
        /* Process each genital mesh one by one */
        if(FKT_FHIDE_N==pTogglePart)
            visible=!getBit(g_RuntimeBodyStateSettings,pTogglePart) *
            (meshes_count==g_CurrentFittedNipState);
        else if(FKT_FHIDE_V==pTogglePart)
            visible=!getBit(g_RuntimeBodyStateSettings,pTogglePart) *
            (meshes_count==g_CurrentFittedVagState);
        else if(FKT_FHIDE_B==pTogglePart)
            visible=!getBit(g_RuntimeBodyStateSettings,pTogglePart) *
            (meshes_count==g_CurrentFittedButState);
        if(FKT_FHIDE_N==pTogglePart)
            mesh_name=llList2String(s_FittedNipsMeshNames,meshes_count);
        else
            mesh_name=llList2String(s_KFTPelvisMeshes,meshes_count);
        list prim_names=xlBladeNameToPrimNames(mesh_name);
        integer prim_count=xlListLen2MaxID(prim_names);
        for(;prim_count> -1;prim_count--){
            integer link_id=llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l
                ,[llList2String(prim_names,prim_count)])+1);
            params +=[PRIM_LINK_TARGET,link_id];
            list faces_l=[];
            if(FKT_FHIDE_N==pTogglePart)
                faces_l=xlGetFacesByBladeName(BLADE_NIPS);
            else if(FKT_FHIDE_V==pTogglePart)
                faces_l=xlGetFacesByBladeName(BLADE_VAG);
            else if(FKT_FHIDE_B==pTogglePart)
                faces_l=xlGetFacesByBladeName(BLADE_VIRTUAL_BUTT);
            integer faces_count=xlListLen2MaxID(faces_l);
            for(;faces_count > -1;--faces_count)
                params+=[PRIM_COLOR,
                    llList2Integer(faces_l,faces_count),<1,1,1>,
                        visible * g_Config_MaximumOpacity
                ];
            #ifdef DEBUG_FACE_SELECT
            llOwnerSay("FACES:"+llList2CSV(faces_l)
                +"|MESH_NAME:"+mesh_name
                +"|PRIM_NAME:"+(string)prim_names
                +"|PRIM_ID:"+(string)prim_count
                +"|visible:"+(string)visible);
            #endif
        }
    }
    #ifdef DEBUG_PARAMS
    llOwnerSay("Params out:"+llList2CSV(params));
    #endif
    return params;
}
xlProcessCommand(string message){
    list data=llParseStringKeepNulls(message,[":"],[]);
    string command=llList2String(data,0);
    #ifdef DEBUG_DATA
    llOwnerSay("Parsing Command:"+message);
    #endif
    integer showit;
    /* filter out and process commands */
    integer ftCommand;
    if(command=="show")
        showit=TRUE;
    else if(command=="hide")
        showit=FALSE;
    else if(command=="setbutt"){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            ftCommand=1;
            g_CurrentFittedButState=llList2Integer(data,1);
            xlSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals(FKT_FHIDE_B));
        }
        return;
    }
    else if(command=="setvag"){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            ftCommand=2;
            g_CurrentFittedVagState=llList2Integer(data,1);
            xlSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals(FKT_FHIDE_V));
        }
        return;
    }
    else if(command=="setnip"){
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
            ftCommand=3;
            g_CurrentFittedNipState=llList2Integer(data,1);
            xlSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals(FKT_FHIDE_N));
        }
        return;
    }
    else{
        #ifdef PRINT_UNHANDLED_COMMANDS
        if(llListFindList(["Ani","eRo","Exp","LEy","REy","reqCLdat"],[llGetSubString(message,0,2)])==-1){
            llOwnerSay("Unhandled command: '"+message+"'");
        }
        #endif
        return;
    }
    integer list_size=xlListLen2MaxID(data);
    #ifdef DEBUG_DATA
    llOwnerSay("list_size="+(string)list_size);
    llOwnerSay("data:"+llList2CSV(data));
    #endif
    list params;
    for(;list_size > 0;list_size--){/* skip command (first element) */
        /* Process a list of blade names */
        string blade_name=llList2String(data,list_size);
        #ifdef DEBUG_COMMAND
        llOwnerSay("[Looping through params]:"+blade_name);
        #endif
        if(blade_name==BLADE_NIPS && getBit(g_RuntimeBodyStateSettings,
            FKT_PRESENT)){
            g_CurrentFittedNipState=showit;
            xlSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals(FKT_FHIDE_N));
        }
        else if(blade_name==BLADE_VAG && getBit(g_RuntimeBodyStateSettings,
            FKT_PRESENT)){
            g_CurrentFittedVagState=showit;
            g_TogglingPGMeshes=TRUE;
            xlSetLinkPrimitiveParamsFast(LINK_SET,xlSetGenitals(FKT_FHIDE_V));
            g_TogglingPGMeshes=FALSE;
        }
        else if(blade_name==BLADE_VAG){
            g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings &
                (~KSB_PGVAGOO)) | (KSB_PGVAGOO * !showit);
            // llOwnerSay("o.o.o.o.o");
            if(!showit && !g_TogglingPGMeshes){
                chgBit(g_RuntimeBodyStateSettings,KSB_PGVAGOO,TRUE);
            }
            else if(showit && g_TogglingPGMeshes)
            chgBit(g_RuntimeBodyStateSettings,KSB_PGVAGOO,FALSE);
        }
        else if(blade_name==BLADE_NIPS){
            // llOwnerSay("o.o.o.o.o");
            g_RuntimeBodyStateSettings=(g_RuntimeBodyStateSettings &
                (~KSB_PGNIPLS)) | (KSB_PGNIPLS * !showit);
            if(!g_TogglingPGMeshes && !showit){
                chgBit(g_RuntimeBodyStateSettings,KSB_PGNIPLS,TRUE);
            }
            else if(g_TogglingPGMeshes && showit)
            chgBit(g_RuntimeBodyStateSettings,KSB_PGNIPLS,FALSE);
        }
        else{
            list params_internal;
            /* When linked against the Fitted Torso, we need to skip the parts
            *  handled by said torso to avoid endless toggling as the fitted torso
            *  requests hiding of the faces it replaces to "fix" the stock body
            */
            /* TODO: Optimize the param creation logic to not include redundant
            *  changes. This implies making it so that there is no post-loop
            *  fixing" happening.
            */
            // #ifdef DEBUG_COMMAND
            // llOwnerSay("xlGetBladeToggleParamsNew Processing:"+blade_name);
            // #endif
            if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
                if(blade_name==BLADE_BREASTS){
                    chgBit(g_RuntimeBodyStateSettings,FKT_FHIDE_N,!showit);
                    params_internal +=xlSetGenitals(FKT_FHIDE_N);
                }
                else if(blade_name==BLADE_PELVIS){
                    chgBit(g_RuntimeBodyStateSettings,FKT_FHIDE_V,!showit);
                    params_internal +=xlSetGenitals(FKT_FHIDE_V);
                }
            }
            else{
            /* TODO: Handle stock body in xlSetVag instead to only keep
            *  the statement above
            */
            if(blade_name==BLADE_PELVIS){
                if(!(g_RuntimeBodyStateSettings & KSB_PGVAGOO) && !showit)
                xlProcessCommand("hide:"+BLADE_VAG);
                else
                xlProcessCommand("show:"+BLADE_VAG);
            }
            else if(blade_name==BLADE_BREASTS){
                    // showit *=!(g_RuntimeBodyStateSettings & KSB_PGNIPLS);
                    // llOwnerSay("GOD NO PLEASE GO AWAY!");
                    if(!(g_RuntimeBodyStateSettings & KSB_PGNIPLS) && !showit)
                    xlProcessCommand("hide:"+BLADE_NIPS);
                        // llOwnerSay("nuuuu");
                        else
                        xlProcessCommand("show:"+BLADE_NIPS);
                    }
                }
                list prim_names=xlBladeNameToPrimNames(blade_name);
                integer blade_prim_iter=xlListLen2MaxID(prim_names);
                #ifdef DEBUG_DATA
                llOwnerSay("prim_names:{"+llList2CSV(prim_names)+"}");
                llOwnerSay("prim_count="+(string)(blade_prim_iter+1));
                #endif
                for(;blade_prim_iter > -1;blade_prim_iter--){
                    /* TODO: Be less nuclear and only fix the faces we asked for*/
                    /* TODO: inline as much as possible */
                    params_internal+=[
                    PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,
                        llListFindList(g_LinkDB_l,[
                            llList2String(prim_names,blade_prim_iter)
                            ])+1)
                    ];
                    list faces_l=xlGetFacesByBladeName(blade_name);
                    integer faces_index=xlListLen2MaxID(faces_l);
                    #ifdef DEBUG_FACE_SELECT
                    llOwnerSay("Prim Count   :"+(string)(blade_prim_iter+1));
                    llOwnerSay("Faces List 1 :"+llList2CSV(faces_l));
                    llOwnerSay("Prim Names   :"+llList2CSV(prim_names));
                    llOwnerSay("Faces Count  :"+(string)(faces_index+1));
                    llOwnerSay("Prim Database:"+llList2CSV(g_LinkDB_l));
                // llOwnerSay("Link Name 1  :"+this_prim_name);
                // llOwnerSay("link_name_index:"+(string)link_name_index);
                // llOwnerSay("Link ID 1    :"+(string)link_id);
                #endif
                for(;faces_index > -1; faces_index--)
                params_internal+=[
                PRIM_COLOR,llList2Integer(faces_l,faces_index),<1,1,1>,
                (showit ^ (BLADE_VAG==blade_name)) *
                g_Config_MaximumOpacity
                ];
            }
            #ifdef DEBUG_PARAMS
            llOwnerSay("Params out:"+llList2CSV(params));
            #endif
            params+=params_internal;
        }
        #ifdef DEBUG_COMMAND
        llOwnerSay("[done with param]:"+blade_name);
        #endif
    }
    xlSetLinkPrimitiveParamsFast(LINK_SET,params);
}
reset(){
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
    xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
        +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
        +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
        +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
        +"elbowR:armLL:armLR:wristL:wristR:handL:handR");
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
        if(change & CHANGED_OWNER)
        llResetScript();
        else if(change & CHANGED_LINK)
        llResetScript(); /* TODO: should really just recalculate */
    }
    state_entry(){
        g_Owner_k=llGetOwner();
        #ifdef DEBUG_TEXT
        llScriptProfiler(PROFILE_SCRIPT_MEMORY);
        #endif
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
            if(!getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
                /* Look if this really is a fitted torso or an accessory for it */
                integer fitted_torso_string_index=llSubStringIndex(name,
                    MESH_FITTED_TORSO);
                if(fitted_torso_string_index > 5)
                if(fitted_torso_string_index < 8){
                    found_fitted_torso = TRUE;
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
            xlProcessCommand("hide:neck:shoulderLR:shoulderLL:shoulderUR:shoulderUL:collar:chest:breast:ribs:abs:belly:pelvis:hipR:hipL:thighUR:thighUL:thighLR:thighLL");
            setBit(g_RuntimeBodyStateSettings,FKT_PRESENT);
        }
        #ifdef DEBUG_ENTIRE_BODY_ALPHA
        llSetLinkPrimitiveParamsFast(LINK_ROOT,prim_params_to_apply);
        #endif
        #ifdef DEBUG_SELF_TEST
        llSetText("[UNIT SELF-TEST]",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        list selftest=["neck","collar","shoulderUL","shoulderUR","shoulderLL",
        "shoulderLR","armUL","armUR","elbowL","elbowR","armLL","armLR",
        "wristL","wristR","handL","handR","chest","breast","ribs","abs",
        "belly","pelvis","hipL","hipR","thighUL","thighUR","thighLL",
        "thighLR","kneeL","kneeR","calfL","calfR","shinUL","shinUR",
        "shinLL","shinLR","ankleL","ankleR","footL","footR"];
        integer id = xlListLen2MaxID(selftest);
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
            +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
            +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
            +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
            +"elbowR:armLL:armLR:wristL:wristR:handL:handR");
        for(;id>-1;id--){
            xlProcessCommand("hide:"+llList2String(selftest,id));
            llSleep(0.0625);
        }
        id = xlListLen2MaxID(selftest);
        for(;id>-1;id--){
            xlProcessCommand("show:"+llList2String(selftest,id));
            llSleep(0.0625);
        }
        #endif
        g_AnimDeform=llGetInventoryName(INVENTORY_ANIMATION,0);
        g_AnimUndeform=llGetInventoryName(INVENTORY_ANIMATION,1);
        #ifdef DEBUG_DATA
        llOwnerSay("Link database: "+llList2CSV(g_LinkDB_l));
        llOwnerSay("Deform:"+g_AnimDeform);
        llOwnerSay("Undeform:"+g_AnimUndeform);
        #endif
        if(llGetAttached())
        llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
        else
        llSetTimerEvent(0.1);
        llSetText("",ZERO_VECTOR,0.0);
        llListen(KEMONO_COM_CH,"","","");
        #ifdef DEBUG_SELF_TEST
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
            +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
            +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
            +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
            +"elbowR:armLL:armLR:wristL:wristR:handL:handR");
        llWhisper(KEMONO_COM_CH,"show:neck:collar:shoulderUL:shoulderUR:"
            +"shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
            +"hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
            +"shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
            +"armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        #endif
    }
    listen(integer channel,string name,key id,string message){
        #ifdef DEBUG_LISTEN
        llOwnerSay("Time:"+(string)llGetTimestamp());
        #endif
        #ifdef DEBUG_LISTEN_FORCE_DROP_SELF
        if(id==llGetKey()) return;
        #endif
        key owner_key=llGetOwnerKey(id);
        #ifdef DEBUG_LISTEN_ALL
        string knp="["+(string)id+"]"+"{"+llKey2Name(id)+"}("
        +llKey2Name(owner_key)+" ";
        llOwnerSay(knp+"input ["+message+"]");
        #endif
        if(owner_key != g_Owner_k && (owner_key!=id)){ /* Eval both, on purpose*/
            return;
        }
        #ifndef DEBUG_LISTEN_ALL
        #ifdef DEBUG_LISTEN
        string knp="["+(string)id+"]"+"{"+llKey2Name(id)+"}("
        +llKey2Name(owner_key)+" ";
        llOwnerSay(knp+"input ["+message+"]");
        #endif
        #endif
        /* TODO: Allow chained commands such as add:show:vagoo:remove*/
        if(message=="add"){ /* And add if not in the auth list */
            if(llGetFreeMemory() > 2048)
            if(llListFindList(g_RemConfirmKeys_l,[id])==-1)
            {
                #ifdef DEBUG_AUTH
                llOwnerSay("Adding " + (string)id + " to auth list");
                #endif
                g_RemConfirmKeys_l +=[id];
            }
            return;
        }
        else if(message=="remove"){ /*If the are in the list, remove them.*/
            integer placeinlist=llListFindList(g_RemConfirmKeys_l,[(key)id]);
            if(placeinlist !=-1){
                #ifdef DEBUG_AUTH
                llOwnerSay("Removing " + (string)id + " from auth list");
                #endif
                g_RemConfirmKeys_l=llDeleteSubList(g_RemConfirmKeys_l,
                    placeinlist,placeinlist);
            }
            return;
        }
        else{
            if(llSubStringIndex(llKey2Name(id), "Kemono - HUD")==-1){
                if(llListFindList(g_RemConfirmKeys_l,[id])==-1){
                    #ifdef DEBUG_AUTH
                    llOwnerSay("Ignoring unauthed " + (string)id);
                    #endif
                    return;
                }
            }
            #ifdef DEBUG_AUTH
            else{
                    llOwnerSay("Hi Kemono HUD");
            }
            #endif
            /* Authorized */
            if(message == "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
                +"shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
                +"thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
                +"shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
                +"elbowR:armLL:armLR:wristL:wristR:handL:handR"){
                reset();
            }
            else if(message=="resetA")
                reset();
            else if(message=="resetB"){
                g_RemConfirmKeys_l=[];
                reset();
            }
            /* TODO: Move at bottom and overwrite 'message' instead in other
            /* branches so that we can inline xlProcessCommand
            */
            else if(llSubStringIndex(message, "show")==0 || llSubStringIndex(message, "hide")==0){
                xlProcessCommand(message);
            }
            else if(message=="Hlegs"){
                #ifdef PROCESS_LEGS_COMMANDS
                if(!human_mode){
                    xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR"
                        +":shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                    human_mode=TRUE;
                    xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR"
                        +":shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                }
                #endif
            }
            else if(message=="Flegs"){
                #ifdef PROCESS_LEGS_COMMANDS
                if(human_mode){
                    xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR"
                        +":shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                    human_mode=FALSE;
                    xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR"
                        +":shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                }
                #endif
            }
            /* TODO: FIXME: Kind of brutal, should probably store the last hand anim or something.*/
            if(message == "Rhand:1"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStartAnimation("Kem-hand-R-relax");
                return;
            }
            else if(message == "Rhand:2"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-hold");
                return;
            }
            else if(message == "Rhand:3"){
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-fist");
                return;
            }
            else if(message == "Rhand:4"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-horns");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-point");
                return;
            }
            else if(message == "Rhand:5"){
                llStopAnimation("Kem-hand-R-fist");
                llStopAnimation("Kem-hand-R-hold");
                llStopAnimation("Kem-hand-R-point");
                llStopAnimation("Kem-hand-R-relax");
                llStartAnimation("Kem-hand-R-horns");
                return;
            }
            else if(message == "Lhand:1"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStartAnimation("Kem-hand-L-relax");
                return;
            }
            else if(message == "Lhand:2"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-hold");
                return;
            }
            else if(message == "Lhand:3"){
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-fist");
                return;
            }
            else if(message == "Lhand:4"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-horns");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-point");
                return;
            }
            else if(message == "Lhand:5"){
                llStopAnimation("Kem-hand-L-fist");
                llStopAnimation("Kem-hand-L-hold");
                llStopAnimation("Kem-hand-L-point");
                llStopAnimation("Kem-hand-L-relax");
                llStartAnimation("Kem-hand-L-horns");
                return;
            }
            else{
                #ifdef FTK_MULTI_DROP
                /* Ignore Starbright's Kemono Torso messages when handling that mesh*/
                if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
                if(llSubStringIndex(name,MESH_FITTED_TORSO) > 3)
                return;
                #endif
                if(llSubStringIndex(message, "resCLdat")==0){
                /* This API isn't public, the best we can do is guess.
                /* Do nothing for now.
                /* if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
                /* ie 'resCLdat:clothID:1064:clothDesc:Top:attachPoint:30:clothState:2'
                /* integer clothID = llList2Integer(data,2);
                /* integer clothDesc = llList2Integer(data,4);
                /* integer attachPoint = llList2Integer(data,6);
                /* integer clothState = llList2Integer(data,8); /*0:on, 1: pulled, 2: removed*/
                /* NOTE: This is part of the internal Starbright API. We shouldn't know
                /* how to handle this and that is fine. Staryna says it's for
                /* careful ordering of stuff. Private and all.
                */
                return;
            }
            else if("reqFTdat"==message){
                #ifdef DEBUG_FUNCTIONS
                llOwnerSay("Sending Data");
                #endif
                if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)){
                    llWhisper(KEMONO_COM_CH,"resFTdat:nipState:"
                        +(string)g_CurrentFittedNipState
                        +":nipAlpha:0" /* TODO: Implement Alpha State*/
                        +":nipOvrd:0" /* TODO: Implement Nipple Override */
                        +":vagState:"+(string)g_CurrentFittedVagState
                        +":buttState:"+(string)g_CurrentFittedButState
                        +":humLegs:"+(string)human_mode);
                }
                return;
            }
            #ifdef DEBUG_LISTEN
            llOwnerSay("End for '" + message + "'");
            #endif
        }
    }
}
on_rez(integer p){
    llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
    #ifdef GITHUB_UPDATER
    g_internal_httprid_k=llHTTPRequest("https://api.github.com/repos/"
        +g_internal_repo_s
        +"/releases/latest?access_token="
        +"603ee815cda6fb45fcc16876effbda017f158bef",
        [HTTP_BODY_MAXLENGTH,16384],"");
    #endif
}
attach(key id){
        /* Deform on detach, unlike the stock body. This assumes permissions
        *  are granted, which happens on rez or startup if attached.
        *  Needs to be processed as fast as possible to make it before the
        *  object is pruned from the Current Outfit Folder otherwise
        *  it won't fire.
        */
        if(id==NULL_KEY){
            llStartAnimation(g_AnimUndeform);
            llSleep(0.1);
            llStopAnimation(g_AnimUndeform);
        }
        else{
            llStopAnimation(g_AnimUndeform);
            llStartAnimation(g_AnimDeform);
        }
    }
    run_time_permissions(integer perm){
        g_HasAnimPerms=TRUE;
        /* Send a "reset" message to forcefully trigger clothing autohiders */
        llWhisper(KEMONO_COM_CH,"show:neck:collar:shoulderUL:shoulderUR:"
            +"shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
            +"hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
            +"shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
            +"armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        llSetTimerEvent(0.1);
    }
    timer(){
        if(llGetAttached()){
            if(!g_HasAnimPerms)
            llRequestPermissions(g_Owner_k,PERMISSION_TRIGGER_ANIMATION);
            else
            llStartAnimation(g_AnimDeform);
        }
        string text;
        #ifdef DEBUG_TEXT
        text="[DEBUG]"+text;
        text+="\nU: "+(string)llGetUsedMemory()+"["+(string)llGetSPMaxMemory()
        +"]/"+(string)llGetMemoryLimit()+"B";
        #ifdef DEBUG_FACE_SELECT
        text+="\nPG_v:"+(string)g_TogglingPGMeshes;
        #endif
        text+="\n"+(string)(xlListLen2MaxID(g_RemConfirmKeys_l)+1)
        +" Keys\n \n ";
        text+="\n \n \n \n \n \n ";
        #endif
        llSetText(text+"\n \n \n \n ",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        llSetTimerEvent(10);
    }
    #ifdef GITHUB_UPDATER
    http_response(key request_id,integer status,list metadata,string body)
    {
        if(request_id !=g_internal_httprid_k) return;// exit if unknown
        g_internal_httprid_k=NULL_KEY;
        string new_version_s=llJsonGetValue(body,["tag_name"]);
        if(new_version_s==g_internal_version_s) return;
        list cur_version_l=llParseString2List(g_internal_version_s,["."],[""]);
        list new_version_l=llParseString2List(new_version_s,["."],[""]);
        string update_type="version";
        // Major
        if(llList2Integer(new_version_l,0) > llList2Integer(cur_version_l,0)){
            update_type="major version"; jump update;
        }
        // Minor
        else if(llList2Integer(new_version_l,1) >
            llList2Integer(cur_version_l,1)){
            update_type="version"; jump update;
        }
        // Patch (bugfix)
        else if(llList2Integer(new_version_l,2) >
            llList2Integer(cur_version_l,2)){
            update_type="patch"; jump update;
        }
        return;
        @update;
        string update_title=llJsonGetValue(body,["name"]);
        if(update_title=="﷕")
        update_title="";
        else update_title=":\n\n"+update_title;
        string update_description=llJsonGetValue(body,["body"]);
        if(update_description=="﷕")
        update_description="";
        else update_description+="\n";
        if(llStringLength(update_description) >=128)
        update_description="Too many changes, see link below.";
        string g_cached_updateMsg_s="A new "+update_type+" (v"+new_version_s
        +") is available!"+update_title+"\n"+update_description+"\n"
        +"Your new scripts (["+"https://github.com/"+g_internal_repo_s
        +"/compare/"+g_internal_version_s+"..."+new_version_s+" Diff "
        +g_internal_version_s+"..."+new_version_s
        +"]):\n[https://raw.githubusercontent.com/"
        +g_internal_repo_s+"/"+new_version_s+"/compiled/"+compiled_name+" "
        +script_name+".lsl]";
        llDialog(g_Owner_k,"[https://github.com/"+g_internal_repo_s +" "
            +script_name+"] v"+g_internal_version_s
            +" by secondlife:///app/agent/f1a73716-4ad2-4548-9f0e-634c7a98fe86"
            +"/inspect.\n"+g_cached_updateMsg_s,["Close"],-1);
    }
    #endif
}
