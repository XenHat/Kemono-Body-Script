/* <<<---- Enlarge window so you see this on only one line for better visibility ---->>>
**
** Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life
** Original creation date: 6/06/2017 22:52:37
** The latest version of this script is located at:
**  https://github.com/XenHat/Kemono-Body-Script/blob/master/xenhat.kemono.body.lsl
**
** Licensed under the Aladdin Free Public License Version 9
** For the Full license, see
**  https://tldrlegal.com/license/aladdin-free-public-license#fulltext
**
** The short human readable version of this licence for the benefit of the reader is:
**
** You CAN:
** Modify
** Distribute
**
** You CANNOT:
**  Hold Liable
**  Sublicense
**  Place Warranty
**  Commercial Use
** You MUST:
**  Include License
**  Include Original
**  State Changes
** An online version of the human-readable version of the AFPL can be found at:
** https://tldrlegal.com/license/aladdin-free-public-license
**
** WARNING: Currently the script does not allow custom coloring to be retained
** due to the way I preserve texturing without needing an applier script.
**
** Please contact the author of this script if you wish to trade that functionality
** for custom coloring support (You will need a full-perm copy of your skin for the
** texturing to work at all.
** This is because I do not have the info required to support the kApp applier.
**/
/*
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
float g_Config_MaximumOpacity = 1.00; // 0.8 // for goo
/*----------------------------------------------------------------------------------- */
/* NO USER-EDITABLE VALUES BELOW THIS LINE */
/* Defines */
// #define DEBUG
// #define DEBUG_TEXT
// #define DEBUG_ENTIRE_BODY_ALPHA
// #define DEBUG_LISTEN
// #define DEBUG_COMMAND
// #define DEBUG_DATA
// #define DEBUG_PARAMS
// #define DEBUG_FACE_SELECT
// #define DEBUG_FACE_TOUCH
// #define DEBUG_FUNCTIONS
// End of debug defines
#define HOVER_TEXT_COLOR <0.825,0.825,0.825>
#define HOVER_TEXT_ALPHA 0.75
#ifdef DEBUG_PARAMS
#define xlSetLinkPrimitiveParamsFast(a,b) llOwnerSay("PARAMS:"+llList2CSV(b));\
llSetLinkPrimitiveParamsFast(a,b)
#else
#define xlSetLinkPrimitiveParamsFast(a,b) llSetLinkPrimitiveParamsFast(a,b)
#endif
/* TODO:
- Fitted Torso nipples alpha setting
- Figure out what reqCLdat is.
- Leg types toggles, see comments below
*/
#define KEMONO_COM_CH -34525475
#define MESH_ARMS "arms"
#define MESH_BODY "body"
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
#define MESH_FITTED_TORSO_ETC "TorsoEtc"
#define MESH_FITTED_TORSO_HLEGS "HumanLegs"
#define MESH_FITTED_TORSO_NIP_0 "NipState0"
#define MESH_FITTED_TORSO_NIP_1 "NipState1"
#define MESH_FITTED_TORSO_NIP_A "NipAlpha"
#define MESH_FITTED_TORSO_CHEST "TorsoChest"
#define MESH_FITTED_TORSO "Fitted Kemono Torso"
#define BLADE_ABS "abs"
#define BLADE_ANKLE_L "ankleL"
#define BLADE_ANKLE_R "ankleR"
#define BLADE_ARM_L_L "armLL"
#define BLADE_ARM_L_R "armLR"
#define BLADE_ARM_U_L "armUL"
#define BLADE_ARM_U_R "armUR"
#define BLADE_BELLY "belly"
#define BLADE_BODY "body"
#define BLADE_BREASTS "breast"
#define BLADE_CALF_L "calfL"
#define BLADE_CALF_R "calfR"
#define BLADE_CHEST "chest"
#define BLADE_COLLAR "collar"
#define BLADE_ELBOW_L "elbowL"
#define BLADE_ELBOW_R "elbowR"
#define BLADE_FITTED_TORSO "Fitted Torso"
#define BLADE_HAND_LEFT "handL"
#define BLADE_HAND_RIGHT "handR"
#define BLADE_HIP_L "hipL"
#define BLADE_HIP_R "hipR"
#define BLADE_KNEE_L "kneeL"
#define BLADE_KNEE_R "kneeR"
#define BLADE_NECK "neck"
#define BLADE_NIPS "nips"
#define BLADE_PELVIS "pelvis"
#define BLADE_PG_LAYER "PG"
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
#define BLADE_FOOT_R "footR"
#define BLADE_FOOT_L "footL"
#define g_supported_meshes [\
MESH_ARMS,\
MESH_BODY,\
MESH_HAND_LEFT,\
MESH_HAND_RIGHT,\
MESH_HIPS,\
MESH_LEG_LEFT_ANIMAL,\
MESH_LEG_LEFT_HUMAN,\
MESH_LEG_RIGHT_ANIMAL,\
MESH_LEG_RIGHT_HUMAN,\
MESH_NECK,\
MESH_PG_LAYER,\
MESH_ROOT,\
MESH_FITTED_TORSO_HLEGS,\
MESH_FITTED_TORSO_CHEST,\
MESH_FITTED_TORSO,\
"BitState0",\
"BitState1",\
"BitState2",\
"BitState3",\
MESH_FITTED_TORSO_NIP_0,\
MESH_FITTED_TORSO_ETC,\
MESH_FITTED_TORSO_NIP_1,\
MESH_FITTED_TORSO_NIP_A,\
"cumButtS1",\
"cumButtS2",\
"cumButtS3"\
]
key g_Owner_k;
list g_RemConfirmKeys_l;
list g_LinkDB_l = [];
list s_FittedNipsMeshNames=[
MESH_FITTED_TORSO_NIP_0, /* PG */
MESH_FITTED_TORSO_ETC, /* Adult, idle */
MESH_FITTED_TORSO_NIP_1, /* Adult, puffy */
MESH_FITTED_TORSO_NIP_A /* Used in Starbright HUD/API */
];
list s_KFTPelvisMeshes=[
"BitState0", /* PG */
"BitState1", /* Adult, idle */
"BitState2", /* Adult, aroused */
"BitState3" /* Adult, gaping */
];
integer g_HasAnimPerms = FALSE;
integer g_CurrentFittedNipState=1;
integer g_CurrentFittedVagState=1;
integer g_CurrentFittedButState=1;
integer g_TogglingPGMeshes=FALSE;
#define FKT_PRESENT 1
/* PG States */
#define KSB_PGVAGOO 2
#define KSB_PGNIPLS 4
/* Temporary flags for blade sync purposes*/
#define FKT_FHIDE_B 8
#define FKT_FHIDE_N 16
#define FKT_FHIDE_V 32
integer g_RuntimeBodyStateSettings;
/* usage:
    a = variable/set
    b = bit (define, see above)
*/
/* Some shorthand operators are not allowed in LSL */
#define clrBit(a,b) a = (a & (~b))
#define setBit(a,b) a = (a | b)
#define chgBit(a,b,c) a = (a & (~b)) | (b * c);
#define togBit(a,b) a ^= 1 << b
/* Note: This one can be used inline */
#define getBit(a,b) (!!(a & b))
string g_AnimDeform;
string g_AnimUndeform;
string g_HoverText;
#define xlListLen2MaxID(a) ((a!=[]) - 1)
integer human_mode=TRUE; /* Prefer when available*/
list xlGetFacesByBladeName(string name) {
    if(name==BLADE_ABS) return [6,7];
    if(name==BLADE_ANKLE_L) {
        if (human_mode) return [1];
        return [5];
    }
    if(name==BLADE_ANKLE_R) {
        if (human_mode)
            return [1];
        return [5];
    }
    if(name==BLADE_ARM_L_L) return [7];
    if(name==BLADE_ARM_L_R) return [2];
    if(name==BLADE_ARM_U_L) return [0];
    if(name==BLADE_ARM_U_R) return [6];
    if(name==BLADE_BELLY) return [2,3];
    if(name==BLADE_BODY) return [0];
    if(name==BLADE_BREASTS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [2,3];
        return [2,5];
    }
    if(name==BLADE_CALF_L) {
        if(human_mode)
            return [4];
        return [2];
    }
    if(name==BLADE_CALF_R) {
        if(human_mode)
            return [4];
        return [2];
    }
    if(name==BLADE_CHEST) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1];
        if(human_mode)
            return [0,4];
        return [0,4];
    }
    if(name==BLADE_COLLAR) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [6,7];
        return [1,6];
    }
    if(name==BLADE_ELBOW_L) return [4];
    if(name==BLADE_ELBOW_R) return [5];
    if(name==BLADE_FOOT_L) return [0];
    if(name==BLADE_FOOT_R) return [0];
    if(name==BLADE_HIP_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [6];
    }
    if(name==BLADE_HIP_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [4];
        return [5];
    }
    if(name==BLADE_KNEE_L) {
        if(human_mode)
            return [5];
        return [1];
    }
    if(name==BLADE_KNEE_R) {
        if(human_mode)
            return [5];
        return [1];
    }
    if(name==BLADE_HAND_LEFT)
        return [-1];
    if(name==BLADE_HAND_RIGHT)
        return [-1];
    if(name==BLADE_NECK) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1];
        return [2,5];
    }
    if(name==BLADE_NIPS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            /* Note: Before changing this again, create a different way of handling the request that doesn't match. This is configured properly for the whole Fitted Torso chest mesh */
            return [0,1];
        return [2,3];
    }
    if(name==BLADE_PELVIS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [0,1,2,3];
        return [0,1];
    }
    if(name==BLADE_RIBS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [4,5];
        return [1,3];
    }
    if(name==BLADE_SHIN_L_L) {
        if (human_mode)
            return [2];
        return [4];
    }
    if(name==BLADE_SHIN_L_R) {
        if (human_mode)
            return [2];
        return [4];
    }
    if(name==BLADE_SHIN_U_L)
        return [3];
    if(name==BLADE_SHIN_U_R)
        return [3];
    if(name==BLADE_SHOULDER_L_L)
        return [3];
    if(name==BLADE_SHOULDER_L_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [2];
        return [0];
    }
    if(name==BLADE_SHOULDER_U_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [7];
    }
    if(name==BLADE_SHOULDER_U_R)
        return [4];
    if(name==BLADE_THIGH_L_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            if(human_mode)
                return [1];
            return [7];
        }
        return [6];
    }
    if(name==BLADE_THIGH_L_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            if(human_mode)
                return [0];
            return [6];
        }
        return [6];
    }
    if(name==BLADE_THIGH_U_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT))
            return [5];
        return [7];
    }
    if(name==BLADE_THIGH_U_R) return [4];
    if(name==BLADE_VAG) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            /* Reminder: On the Fitted Torso, this is the upper hip mesh half. The bottom hip mesh half is controlled independently using setbutt */
            if(g_TogglingPGMeshes)
                return [0,1,2,3,4,5];
            return [0,1];
        }
        return [0,1];
    }
    if(name==BLADE_VIRTUAL_BUTT) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            /* Reminder: On the Fitted Torso, this is the upper hip mesh half. The bottom hip mesh half is controlled independently using setbutt */
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
list xlBladeNameToPrimNames(string name) {
    /* TODO Can't we return the link number directly (using less than 512 bytes of code!) without an additional function call? */
    list prim_name = [name];
    #ifdef DEBUG_FACE_SELECT
    llOwnerSay("xlBladeNameToPrimNames("+name+")");
    #endif
    if(name==BLADE_ARM_L_L) prim_name = [MESH_ARMS];
    else if(name==BLADE_ARM_L_R) prim_name = [MESH_ARMS];
    else if(name==BLADE_ARM_U_L) prim_name = [MESH_ARMS];
    else if(name==BLADE_ARM_U_R) prim_name = [MESH_ARMS];
    else if(name==BLADE_ELBOW_L) prim_name = [MESH_ARMS];
    else if(name==BLADE_ELBOW_R) prim_name = [MESH_ARMS];
    else if(name==BLADE_WRIST_L) prim_name = [MESH_ARMS];
    else if(name==BLADE_WRIST_R) prim_name = [MESH_ARMS];
    else if(name==BLADE_RIBS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            prim_name = [MESH_FITTED_TORSO_CHEST];
        }
        else {
            prim_name = [MESH_BODY];
        }
    }
    else if(name==BLADE_ABS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            prim_name = [MESH_FITTED_TORSO_CHEST];
        }
        else {
            prim_name = [MESH_BODY];
        }
    }
    else if(name==BLADE_BODY) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            prim_name = [MESH_FITTED_TORSO_CHEST];
        }
        else {
            prim_name = [MESH_BODY];
        }
    }
    else if(name==BLADE_BREASTS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            prim_name = [MESH_FITTED_TORSO_CHEST];
        }
        else {
            prim_name = [MESH_BODY];
        }
    }
    else if(name==BLADE_CHEST) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            prim_name = [MESH_FITTED_TORSO_CHEST];
        }
        else {
            prim_name = [MESH_BODY];
        }
    }
    else if(name==BLADE_COLLAR) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO];
        else {
            prim_name = [MESH_NECK];
        }
    }
    else if(name==BLADE_HAND_LEFT) prim_name = [MESH_HAND_LEFT];
    else if(name==BLADE_HAND_RIGHT) prim_name = [MESH_HAND_RIGHT];
    else if(name==BLADE_HIP_L || name==BLADE_HIP_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            /* TODO: Handle PG/vagoo/butt states properly */
            prim_name = [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        }
        else {
            prim_name = [MESH_HIPS];
        }
    }
    else if(name==BLADE_NECK) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO];
        else {prim_name = [MESH_NECK];}
    }
    else if(name==BLADE_PELVIS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            /* TODO: Handle PG/vagoo/butt states properly */
            prim_name = [llList2String(s_KFTPelvisMeshes,g_CurrentFittedVagState)];
        }
        else {
            prim_name = [MESH_HIPS];
        }
    }
    else if(name==BLADE_KNEE_R) {
        if(human_mode) {
            prim_name = [MESH_LEG_RIGHT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_RIGHT_ANIMAL];
        }
    }
    else if(name==BLADE_FOOT_R) {
        if(human_mode) {
            prim_name = [MESH_LEG_RIGHT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_RIGHT_ANIMAL];
        }
    }
    else if(name==BLADE_ANKLE_R) {
        if(human_mode) {
            prim_name = [MESH_LEG_RIGHT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_RIGHT_ANIMAL];
        }
    }
    else if(name==BLADE_SHIN_U_R) {
        if(human_mode) {
            prim_name = [MESH_LEG_RIGHT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_RIGHT_ANIMAL];
        }
    }
    else if(name==BLADE_CALF_R) {
        if(human_mode) {
            prim_name = [MESH_LEG_RIGHT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_RIGHT_ANIMAL];
        }
    }
    else if(name==BLADE_SHIN_L_R) {
        if(human_mode) {
            prim_name = [MESH_LEG_RIGHT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_RIGHT_ANIMAL];
        }
    }
    else if(name==BLADE_CALF_L) {
        if(human_mode) {
            prim_name = [MESH_LEG_LEFT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_LEFT_ANIMAL];
        }
    }
    else if(name==BLADE_ANKLE_L) {
        if(human_mode) {
            prim_name = [MESH_LEG_LEFT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_LEFT_ANIMAL];
        }
    }
    else if(name==BLADE_FOOT_L) {
        if(human_mode) {
            prim_name = [MESH_LEG_LEFT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_LEFT_ANIMAL];
        }
    }
    else if(name==BLADE_KNEE_L) {
        if(human_mode) {
            prim_name = [MESH_LEG_LEFT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_LEFT_ANIMAL];
        }
    }
    else if(name==BLADE_SHIN_L_L) {
        if(human_mode) {
            prim_name = [MESH_LEG_LEFT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_LEFT_ANIMAL];
        }
    }
    else if(name==BLADE_SHIN_U_L) {
        if(human_mode) {
            prim_name = [MESH_LEG_LEFT_HUMAN];
        }
        else {
            prim_name = [MESH_LEG_LEFT_ANIMAL];
        }
    }
    else if(name==BLADE_SHOULDER_L_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO];
        else {prim_name = [MESH_NECK];}
    }
    else if(name==BLADE_SHOULDER_L_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO];
        else {prim_name = [MESH_NECK];}
    }
    else if(name==BLADE_SHOULDER_U_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO];
        else {prim_name = [MESH_NECK];}
    }
    else if(name==BLADE_SHOULDER_U_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO];
        else {prim_name = [MESH_NECK];}
    }
    else if(name==BLADE_THIGH_U_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO_ETC];
        else {
            prim_name = [MESH_HIPS];
        }
    }
    else if(name==BLADE_THIGH_U_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO_ETC];
        else {
            prim_name = [MESH_HIPS];
        }
    }
    else if(name==BLADE_BELLY) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) prim_name = [MESH_FITTED_TORSO_ETC];
        else {
            prim_name = [MESH_HIPS];
        }
    }
    else if(name==BLADE_NIPS) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            prim_name = [llList2String(s_FittedNipsMeshNames, g_CurrentFittedNipState)];
            // return;
        }
        else {
            prim_name = [MESH_PG_LAYER];
        }
    }
    else if(name==BLADE_VAG) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            if(g_TogglingPGMeshes) {
                prim_name = [llList2String(s_KFTPelvisMeshes, 0)];
            }
            else {
                prim_name = [llList2String(s_KFTPelvisMeshes, g_CurrentFittedVagState)];
            }
        }
        else {
            prim_name = [MESH_PG_LAYER];
        }
    }
    else if(name==BLADE_THIGH_L_R) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            if(human_mode) {
                prim_name = [MESH_FITTED_TORSO_HLEGS];
            }
            else {
                prim_name = [MESH_FITTED_TORSO_ETC];
            }
        }
        else {
            if(human_mode) {
                prim_name = [MESH_LEG_RIGHT_HUMAN];
            }
            else {
                prim_name = [MESH_LEG_RIGHT_ANIMAL];
            }
        }
    }
    else if(name==BLADE_THIGH_L_L) {
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            if(human_mode) {
               prim_name = [MESH_FITTED_TORSO_HLEGS];
            }
            else {
                prim_name = [MESH_FITTED_TORSO_ETC];
            }
        }
        else {
            if(human_mode) {
                prim_name = [MESH_LEG_LEFT_HUMAN];
            }
            else {
                prim_name = [MESH_LEG_LEFT_ANIMAL];
            }
        }
    }
    return prim_name;
}
/* Stock Fitted Torso script:
setnip0 == NipState0
setnip1 == TorsoEtc[0,1]
setnip2 == NipState1
NipAlpha == ????
*/
/* Note: The Starbright stock behavior is the following:
Show PG layer when hiding nipples
Forcefully set the current nipple type to Adult, idle on PG disable
*/
list xlSetNip() {
    #ifdef DEBUG_FUNCTIONS
    llOwnerSay("xlSetNip");
    #endif
    list params;
    /* Nip meshes */
    {
        integer meshes_count = xlListLen2MaxID(s_FittedNipsMeshNames); /* todo: hard-code */
        for(;meshes_count > -1;meshes_count--) {
            integer visible = !getBit(g_RuntimeBodyStateSettings,FKT_FHIDE_N)
                * (meshes_count == g_CurrentFittedNipState);
            /* Process each nipple mesh one by one */
            string mesh_name = llList2String(s_FittedNipsMeshNames,meshes_count);
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer prim_count = xlListLen2MaxID(prim_names);
            for(;prim_count> -1;prim_count--){
                integer link_id = llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[llList2String(prim_names,prim_count)])+1);
                params += [PRIM_LINK_TARGET,link_id];
                list faces_l = xlGetFacesByBladeName(BLADE_NIPS);
                integer faces_count = xlListLen2MaxID(faces_l);
                for(;faces_count > -1;--faces_count) {
                    params+=[PRIM_COLOR,llList2Integer(faces_l,faces_count), <1,1,1>, visible
                    * g_Config_MaximumOpacity];
                }
                #ifdef DEBUG_FACE_SELECT
                llOwnerSay("BLADENAME:"+BLADE_NIPS+"|FACES:"+llList2CSV(faces_l)
                    +"|MESH_NAME:"+mesh_name+"|PRIM_NAME:"+(string)prim_names+"|PRIM_ID:"+(string)prim_count
                    +"|visible:"+(string)visible);
                #endif
            }
        }
    }
    #ifdef DEBUG_PARAMS
    llOwnerSay("Params out:" + llList2CSV(params));
    #endif
    return params;
}
list xlSetVag() {
    #ifdef DEBUG_FUNCTIONS
    llOwnerSay("xlSetVag");
    #endif
    list params;
    /* Vagoo meshes */
    {
        integer meshes_count = xlListLen2MaxID(s_KFTPelvisMeshes); /* todo: hard-code */
        for(;meshes_count > -1;meshes_count--) {
            integer visible = !getBit(g_RuntimeBodyStateSettings,FKT_FHIDE_V)
                * (meshes_count == g_CurrentFittedVagState);
            /* Process each nipple mesh one by one */
            string mesh_name = llList2String(s_KFTPelvisMeshes,meshes_count);
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer prim_count = xlListLen2MaxID(prim_names);
            for(;prim_count> -1;prim_count--){
                integer link_id = llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[llList2String(prim_names,prim_count)])+1);
                params += [PRIM_LINK_TARGET,link_id];
                list faces_l = xlGetFacesByBladeName(BLADE_VAG);
                integer faces_count = xlListLen2MaxID(faces_l);
                for(;faces_count > -1;--faces_count) {
                    params+=[PRIM_COLOR,llList2Integer(faces_l,faces_count), <1,1,1>, visible
                    * g_Config_MaximumOpacity];
                }
                #ifdef DEBUG_FACE_SELECT
                llOwnerSay("BLADENAME:"+BLADE_VAG+"|FACES:"+llList2CSV(faces_l)
                    +"|MESH_NAME:"+mesh_name+"|PRIM_NAME:"+(string)prim_names+"|PRIM_ID:"+(string)prim_count
                    +"|visible:"+(string)visible);
                #endif
            }
        }
    }
    #ifdef DEBUG_FACE_SELECT
    #ifdef DEBUG_PARAMS
    llOwnerSay("Params out:" + llList2CSV(params));
    #endif
    #endif
    return params;
}
list xlSetBut() {
    #ifdef DEBUG_FUNCTIONS
    llOwnerSay("xlSetBut");
    #endif
    list params;
    /* Butt meshes */
    {/* Essentially the same as above, but using different prim/mesh names*/
        integer meshes_count = xlListLen2MaxID(s_KFTPelvisMeshes); /* todo: hard-code */
        for(;meshes_count > -1;meshes_count--) {
            integer visible = !getBit(g_RuntimeBodyStateSettings,FKT_FHIDE_B)
                * (meshes_count == g_CurrentFittedButState);
            /* Process each nipple mesh one by one */
            string mesh_name = llList2String(s_KFTPelvisMeshes,meshes_count);
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer prim_count = xlListLen2MaxID(prim_names);
            for(;prim_count> -1;prim_count--){
                integer link_id = llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[llList2String(prim_names,prim_count)])+1);
                params += [PRIM_LINK_TARGET,link_id];
                list faces_l = xlGetFacesByBladeName(BLADE_VIRTUAL_BUTT);
                integer faces_count = xlListLen2MaxID(faces_l);
                for(;faces_count > -1;--faces_count) {
                    params+=[PRIM_COLOR,llList2Integer(faces_l,faces_count), <1,1,1>, visible
                    * g_Config_MaximumOpacity];
                }
                #ifdef DEBUG_FACE_SELECT
                llOwnerSay("BLADENAME:"+BLADE_VIRTUAL_BUTT+"|FACES:"+llList2CSV(faces_l)
                    +"|MESH_NAME:"+mesh_name+"|PRIM_NAME:"+(string)prim_names+"|PRIM_ID:"+(string)prim_count
                    +"|visible:"+(string)visible);
                #endif
            }
        }
    }
    #ifdef DEBUG_FACE_SELECT
    #ifdef DEBUG_PARAMS
    llOwnerSay("Params out:" + llList2CSV(params));
    #endif
    #endif
    return params;
}
/* Process a list of blade names */
list xlGetBladeToggleParamsNew(string blade_name, integer showit) {
    list params;
    /* When linked against the Fitted Torso, we need to skip the parts handled by said torso to avoid endless toggling as the fitted torso requests hiding of the faces it replaces to "fix" the stock body */
    /* TODO: Optimize the param creation logic to not include redundant changes. This implies making it so that there is no post-loop "fixing" happening. */
    #ifdef DEBUG_COMMAND
    llOwnerSay("xlGetBladeToggleParamsNew Processing:"+blade_name);
    #endif
    if (blade_name==BLADE_BREASTS/* || blade_name==BLADE_NIPS*/) {
        chgBit(g_RuntimeBodyStateSettings,FKT_FHIDE_N,!showit);
        params += xlSetNip();
    }
    else if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT) && blade_name==BLADE_PELVIS) {
        chgBit(g_RuntimeBodyStateSettings,FKT_FHIDE_V,!showit);
        params += xlSetVag();
    }
    /* TODO: Handle stock body in xlSetVag instead to only keep the statement above */
    else if(!getBit(g_RuntimeBodyStateSettings,FKT_PRESENT) && blade_name==BLADE_PELVIS) {
        blade_name = BLADE_VAG;
        showit *= !(g_RuntimeBodyStateSettings & KSB_PGVAGOO);
    }
    /* else */
    {
        #ifdef DEBUG_FUNCTIONS
        if(BLADE_NIPS == blade_name) {
            llOwnerSay("GOD NO PLEASE GO AWAY!");
        }
        #endif
        list prim_names = xlBladeNameToPrimNames(blade_name);
        integer blade_prim_iter = xlListLen2MaxID(prim_names);
        #ifdef DEBUG_DATA
        llOwnerSay("prim_names:{"+llList2CSV(prim_names)+"}");
        llOwnerSay("prim_count="+(string)(blade_prim_iter+1));
        #endif
        do{
            string this_prim_name = llList2String(prim_names,blade_prim_iter);
            /* Fix legs automatically */
            /* TODO: Be less nuclear and only fix the faces we asked for*/
            // if (!human_mode && (MESH_LEG_LEFT_ANIMAL == this_prim_name || MESH_LEG_RIGHT_ANIMAL == this_prim_name)) {
            //     params += [PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[MESH_LEG_LEFT_HUMAN])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>, FALSE,
            //         PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[MESH_LEG_RIGHT_HUMAN])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>, FALSE
            //     ];
            // }
            // else if (human_mode && (MESH_LEG_LEFT_HUMAN == this_prim_name || MESH_LEG_RIGHT_HUMAN == this_prim_name)) {
            //     params += [PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[MESH_LEG_LEFT_ANIMAL])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>, FALSE,
            //         PRIM_LINK_TARGET,llList2Integer(g_LinkDB_l,llListFindList(g_LinkDB_l,[MESH_LEG_RIGHT_ANIMAL])+1),PRIM_COLOR,ALL_SIDES,<1,1,1>, FALSE
            //     ];
            // }
            /* TODO: inline as much as possible */
            integer link_name_index = llListFindList(g_LinkDB_l,[this_prim_name]);
            integer link_id = llList2Integer(g_LinkDB_l,link_name_index+1);
            #ifdef DEBUG_DATA
            llOwnerSay("this_prim_name="+this_prim_name);
            llOwnerSay("Database query result= Prim Name:"+llList2String(g_LinkDB_l,link_name_index)+",Prim ID:"+(string)link_id);
            #endif
            params+=[PRIM_LINK_TARGET,link_id];
            list faces_l = xlGetFacesByBladeName(blade_name);
            integer faces_index = xlListLen2MaxID(faces_l);
            integer SHOWIT_VAGOO = showit ^ (BLADE_VAG==blade_name);
            #ifdef DEBUG_FACE_SELECT
            llOwnerSay("Prim Count   :"+(string)(blade_prim_iter+1));
            llOwnerSay("Faces List 1 :"+llList2CSV(faces_l));
            llOwnerSay("Prim Names   :"+llList2CSV(prim_names));
            llOwnerSay("Faces Count  :"+(string)(faces_index+1));
            llOwnerSay("Prim Database:"+llList2CSV(g_LinkDB_l));
            llOwnerSay("Link Name 1  :"+this_prim_name);
            llOwnerSay("link_name_index:"+(string)link_name_index);
            llOwnerSay("Link ID 1    :"+(string)link_id);
            #endif
            do{
                #ifdef DEBUG_FACE_SELECT
                llOwnerSay("Processing["+(string)SHOWIT_VAGOO+"] Face["+this_prim_name+"]:"+llList2String(faces_l,faces_index));
                #endif
                params+=[PRIM_COLOR, llList2Integer(faces_l,faces_index), <1,1,1>, SHOWIT_VAGOO * g_Config_MaximumOpacity];
                faces_index--;
            }
            while(faces_index > -1);
            blade_prim_iter--;
        }
        while(blade_prim_iter> -1);
    }
    #ifdef DEBUG_PARAMS
    llOwnerSay("Params out:" + llList2CSV(params));
    #endif
    return params;
}
xlProcessCommand(string message) {
    list data = llParseStringKeepNulls(message,[":"],[]);
    #ifdef DEBUG_COMMAND
    llOwnerSay("==============");
    #ifdef DEBUG_DATA
    llOwnerSay("Command:"+llList2CSV(data));
    #endif
    #endif
    integer showit;
    string command = llList2String(data,0);
    /* filter out and process commands */
    if(command == "show") {
        showit = TRUE;
    }
    else if(command == "hide") {
        showit = FALSE;
    }
    else if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT) && command=="setbutt") {
        g_CurrentFittedButState = llList2Integer(data,1);
        xlSetLinkPrimitiveParamsFast(LINK_SET, xlSetBut());
        return;
    }
    else if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT) && command=="setvag") {
        /* Vagoo */
        g_CurrentFittedVagState = llList2Integer(data,1);
        xlSetLinkPrimitiveParamsFast(LINK_SET, xlSetVag());
        // return;
    }
    else if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT) && command=="setnip") {
        g_CurrentFittedNipState = llList2Integer(data,1);
        xlSetLinkPrimitiveParamsFast(LINK_SET, xlSetNip());
        return;
    }
    else {
        return;
    }
    command="";
    list params;
    string part_wanted_s = llList2String(data, 1);
    integer list_size = xlListLen2MaxID(data);
        #ifdef DEBUG_DATA
        llOwnerSay("Special message:" + part_wanted_s);
        #endif
        if(part_wanted_s == BLADE_NIPS && getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            g_CurrentFittedNipState = showit;
            xlSetLinkPrimitiveParamsFast(LINK_SET, xlSetNip());
            return;
        }
        else if(part_wanted_s == BLADE_VAG && getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            g_CurrentFittedVagState = showit;
            g_TogglingPGMeshes=TRUE;
            xlSetLinkPrimitiveParamsFast(LINK_SET, xlSetVag());
            g_TogglingPGMeshes=FALSE;
            return;
        }
        else if(part_wanted_s==BLADE_VAG) {
            g_RuntimeBodyStateSettings = (g_RuntimeBodyStateSettings & (~KSB_PGVAGOO)) | (KSB_PGVAGOO * !showit);
           if(!showit && !g_TogglingPGMeshes) {
               #ifdef DEBUG_COMMAND
               llOwnerSay("TOGGLING TO PG");
               #endif
               chgBit(g_RuntimeBodyStateSettings,KSB_PGVAGOO,TRUE);
           }
           if(showit && g_TogglingPGMeshes) {
               #ifdef DEBUG_COMMAND
               llOwnerSay("TOGGLING FROM PG");
               #endif
               chgBit(g_RuntimeBodyStateSettings,KSB_PGVAGOO,FALSE);
           }
           #ifdef DEBUG_COMMAND
           llOwnerSay("PG Mode:"+(string)(g_TogglingPGMeshes));
           #endif
        }
    #ifdef DEBUG_DATA
    llOwnerSay("list_size="+(string)list_size);
    llOwnerSay("data:"+llList2CSV(data));
    #endif
    do{
        part_wanted_s = llList2String(data, list_size);
        #ifdef DEBUG_DATA
        if(part_wanted_s == "") {
            llOwnerSay("BAD, BAD, BLADE NAME IS EMPTY!!!!");
        }
        #endif
        #ifdef DEBUG_COMMAND
        llOwnerSay("Processing:"+part_wanted_s);
        #endif
        params += xlGetBladeToggleParamsNew(part_wanted_s,showit);
        list_size--;
    } while(list_size > 0); /* skip first element, which is the command*/
    if(params!=[]) {
        #ifdef DEBUG_COMMAND
        llOwnerSay("Applying!");
        #endif
        xlSetLinkPrimitiveParamsFast(LINK_SET, params);
        params=[];
    }
}
default {
    #ifdef DEBUG_FACE_TOUCH
    touch_start(integer total_number) {
        key tk = llDetectedKey(0);
        if(tk!=g_Owner_k) return;
        llRegionSayTo(tk,0,
            "ID:"+(string)llDetectedLinkNumber(0)+";prim_name=\""+llGetLinkName(llDetectedLinkNumber(0))+"\";face_list=["+(string)llDetectedTouchFace(0)+"];break;");
    }
    #endif
    changed(integer change) {
        if (change & CHANGED_OWNER) {
            llOwnerSay("The owner of the object has changed, resetting...");
            llResetScript();
        }
        if(change & CHANGED_LINK) {
            llOwnerSay("Link changed, resetting..."); /* TODO: should really just recalculate */
            llResetScript();
        }
    }
    state_entry() {
        #ifdef DEBUG_TEXT
        llScriptProfiler(PROFILE_SCRIPT_MEMORY);
        #endif
        llSetText("Please wait...",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        g_Owner_k = llGetOwner();
        #ifdef DEBUG
        llSetText("UNIT SELF-TEST",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        llSay(0,"g_RuntimeBodyStateSettings: " + (string)g_RuntimeBodyStateSettings);
        llSay(0,"FKT_PRESENT: " + (string)FKT_PRESENT);
        integer test1 = getBit(g_RuntimeBodyStateSettings,FKT_PRESENT);
        llSay(0,"Test1: " + (string)test1);
        setBit(g_RuntimeBodyStateSettings,FKT_PRESENT);
        integer test2 = getBit(g_RuntimeBodyStateSettings,FKT_PRESENT);
        llSay(0,"Test2: " + (string)test2);
        llOwnerSay("Counting");
        #endif
        integer part = llGetNumberOfPrims();
        #ifdef DEBUG_ENTIRE_BODY_ALPHA
        string texture = llGetInventoryName(INVENTORY_TEXTURE,0);
        integer retexture = texture != "";
        list prim_params_to_apply = [];
        #endif
        for (; part > 0; --part) {
            string name = llGetLinkName(part);
            llSetText("\n \n \n \n \n \n["+(string)llGetFreeMemory()+"]Processing " + name + "...",<0,0,0>,1.0);
            integer fitted_torso_string_index = llSubStringIndex(name, MESH_FITTED_TORSO);
            if(fitted_torso_string_index != -1) {
                /* Look if this really is a fitted torso or an accessory for it */
                if(fitted_torso_string_index == 6 || fitted_torso_string_index == 7) {
                    /* We are linked with starnya's Fitted Torso*/
                    setBit(g_RuntimeBodyStateSettings,FKT_PRESENT);
                    name=MESH_FITTED_TORSO;
                }
            }
            if(llListFindList(g_supported_meshes, [name])!= -1) {
                #ifdef DEBUG_ENTIRE_BODY_ALPHA
                prim_params_to_apply += [PRIM_LINK_TARGET,part,PRIM_COLOR,ALL_SIDES,<1,1,1>,0.0];
                if(retexture) {
                    prim_params_to_apply+= [PRIM_TEXTURE,ALL_SIDES, texture, <1,1,0>,<0,0,0>,0.0];
                }
                #endif
                g_LinkDB_l+=[name,part];
            }
        }
        /* The Starbright body Stripper has an option to leave the human legs out, so check if these are present at all*/
        /* TODO: FIXME: Undefined behavior if no legs from kemono body */
        if(llListFindList(g_LinkDB_l, [MESH_LEG_RIGHT_HUMAN]) < 0) {
            /* Forcefully set to human mode if the animal legs aren't found*/
            human_mode=FALSE;
        }
        if(llListFindList(g_LinkDB_l, [MESH_LEG_RIGHT_ANIMAL]) < 0) {
            /* Forcefully set to animal mode if the human legs aren't found*/
            human_mode=TRUE;
        }
        llSetText("",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        #ifdef DEBUG
        llOwnerSay("Link database: " + llList2CSV(g_LinkDB_l));
        #endif
        #ifdef DEBUG_ENTIRE_BODY_ALPHA
        llSetLinkPrimitiveParamsFast(LINK_ROOT, prim_params_to_apply);
        #endif
        llSetText("Resetting Faces",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        /* Reset faces*/
        /* Warning: This command contains an additional "show:nips" and "show:vagoo:" not desired in the reset command*/
        /* TODO: Persistent storage for states to avoid resetting everything to have a consistent state */
        human_mode=!human_mode;
        xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
        human_mode=!human_mode;
        xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
        xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        xlProcessCommand("show:nips:vagoo");
        /* I used texture because TEXTURE_TRANSPARENT tends to disappear totally on some viewers, which is preferable.*/
        /* TODO: Validate that the root prim is not a body part then scrub and hide it */
        /* if(llGetAttached()) {llSetLinkTexture(LINK_ROOT, TEXTURE_TRANSPARENT, ALL_SIDES);} */
        /* else {llSetLinkTexture(LINK_ROOT, TEXTURE_BLANK, ALL_SIDES);} */
        llSetText("Set Listeners"+BLADE_THIGH_L_R,HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
        llListen(KEMONO_COM_CH,"","","");
        llSetText("",HOVER_TEXT_COLOR,0.0);
        g_AnimDeform = llGetInventoryName(INVENTORY_ANIMATION, 0);
        g_AnimUndeform = llGetInventoryName(INVENTORY_ANIMATION, 1);
        #ifdef DEBUG
        llOwnerSay("Deform:"+g_AnimDeform);
        llOwnerSay("Undeform:"+g_AnimUndeform);
        #endif
        if(llGetAttached()) {
            llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
        }
        llSetText("",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA);
    }
    listen( integer channel, string name, key id, string message ) {
        key owner_key = llGetOwnerKey(id);
        #ifdef DEBUG_LISTEN_FORCE_DROP_SELF
        if (id == llGetKey()) return;
        #endif
        #ifdef DEBUG_LISTEN
        string knp;
        knp = "["+(string)id+"]"+"{"+llKey2Name(id)+"}("+llKey2Name(llGetOwnerKey(id))+" ";
        llOwnerSay(knp+"input ["+message+"]");
        #endif
        /* Ignore Starbright's Kemono Torso messages when handling that mesh*/
        if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
            if(llSubStringIndex(name,MESH_FITTED_TORSO) > 3) {
                return;
            }
        }
        /*If we can't get a valid owner...*/
        if(owner_key == id) {
            /*And if they aren't in the auth list, ignore them.*/
            if(llListFindList(g_RemConfirmKeys_l,[id]) == -1) {
                return;
            }
        }
        /*If they don't have the same owner, ignore them.*/
        else if(owner_key != g_Owner_k) {
            return;
        }
        if("reqFTData" == message){
            if(getBit(g_RuntimeBodyStateSettings,FKT_PRESENT)) {
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
        if(message == "add") {
            /*And if they aren't in the auth list, add them.*/
            if (llGetFreeMemory() <= 2048) {
                g_HoverText = " Out of Memory!";
                return;
            }
            if(llListFindList(g_RemConfirmKeys_l,[id]) == -1) {
                g_RemConfirmKeys_l += [id];
                return;
            }
        }
        if(message == "remove") {
            /*If the are in the list, remove them.*/
            integer placeinlist = llListFindList(g_RemConfirmKeys_l, [(key)id]);
            if (placeinlist != -1) {
                g_RemConfirmKeys_l = llDeleteSubList(g_RemConfirmKeys_l, placeinlist, placeinlist);
            }
        }
        if (message=="Hlegs") {
            if(!human_mode) {
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=TRUE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }
        else if(message=="Flegs") {
            if(human_mode) {
                xlProcessCommand("hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
                human_mode=FALSE;
                xlProcessCommand("show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR");
            }
        }
        /* Restore compatibility with old scripts*/
        else if(message=="resetA") {
            xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        }
        else if(message=="resetB") {
            xlProcessCommand("show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
            g_RemConfirmKeys_l=[];
        }
        else {
            xlProcessCommand(message);
            #ifdef DEBUG_COMMAND
            #ifdef DEBUG_LISTEN
            llOwnerSay("Sucessfully consumed "+knp+"'s [http://"+message+" command]");
            #endif
            #endif
        }
    }
    attach(key id) {
        /* Deform on detach, unlike the stock body. This assumes permissions are granted,
            which happen on rez or startup if attached.
            Needs to be processed as fast as possible to make it before the object
            is pruned from the Current Outfit Folder otherwise it won't fire. */
        if(id == (key)NULL_KEY) {
            llStartAnimation(g_AnimUndeform);
            return;
        }
        llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
    }
    run_time_permissions(integer perm) {
        g_HasAnimPerms=TRUE;
        /* Send a "reset" message to forcefully trigger clothing autohiders */
        llWhisper(KEMONO_COM_CH,"show:neck:collar:shoulderUL:shoulderUR:shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
        llSetTimerEvent(0.1);
    }
    timer() {
        if(llGetAttached()) {
            if(!g_HasAnimPerms) {
                llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
            }
            else {
                llStartAnimation(g_AnimDeform);
            }
        }
        string text = g_HoverText;
#ifdef DEBUG_TEXT
        text = "[DEBUG]" + text;
        text+="\nU: "+(string)llGetUsedMemory()+"["+(string)llGetSPMaxMemory()+"]/"+(string)llGetMemoryLimit()+"B";
        #ifdef DEBUG_FACE_SELECT
        text+="\nPG_v:"+(string)g_TogglingPGMeshes;
        #endif
        text+="\n"+(string)xlListLen2MaxID(g_RemConfirmKeys_l)+" Keys\n \n ";
        text+="\n \n \n \n \n \n ";
#endif
        llSetText(text+"\n \n \n \n ", HOVER_TEXT_COLOR, HOVER_TEXT_ALPHA);
        llSetTimerEvent(10);
    }
}
