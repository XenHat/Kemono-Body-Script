/* <-- Enlarge window so you see this on only one line for better visibility -->
Aftermarket Kemono Body Script Replacement by Xenhat Liamano @ Second Life
Original creation date: 6/06/2017 22:52:37
The latest version of this script is located at:
https://github.com/XenHat/Kemono-Body-Script/
License: https://tldrlegal.com/license/aladdin-free-public-license
*/
float g_Config_MaximumOpacity = 1.00; // 0.8 // for goo
vector g_Config_BladeColor = <1, 1, 1>;
integer g_Config_EnsureMaskingMode = 0;
/* Debugging */
/* TODO: Remove no longer needed code toggles here */
// #define BENCHMARK
// #define PROFILE_BODY_SCRIPT
/* End of debug defines */
/* Normal Features that should be enabled */
integer anim_count;
/* Optional features, if you need them. */
// #define SMART_DEFORM
// ============================================================================
/*-------------------------------------------------------------------------- */
/* NO USER-EDITABLE VALUES BELOW THIS LINE */
// =============================== Script begins here =========================
string g_internal_version_s = "0.5.7";
#define UPDATER_NAME "[XenLab] Enhanced Kemono Updater"
#define PROCESS_LEGS_COMMANDS
#define HOVER_TEXT_COLOR <0.925,0.925,0.925>
#define HOVER_TEXT_ALPHA 0.75
// #define debugLogic(a)//llOwnerSay(#a + " == " + (string)a);llSetText("U: " + (string)llGetUsedMemory() + "[" + (string)llGetSPMaxMemory() + "]/" + (string)llGetMemoryLimit() + "B",HOVER_TEXT_COLOR,HOVER_TEXT_ALPHA)
// #define dSay(a)//llOwnerSay((string)a)
#define saveSettings() llSetObjectDesc(g_internal_version_s\
  + "*" + (string)human_mode\
  + "*" + (string)g_Config_BladeColor\
  )
#define xlSetLinkPrimitiveParamsFast(a,b) llSetLinkPrimitiveParamsFast(a,b)
#define KM_HUD_RESET_CMD "show:neck:collar:shoulderUL:shoulderUR:shoulderLL\
:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR\
:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR\
:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR\
:armUL:armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR"
/* TODO:
-  Set Nipple Override
0 = Off : 1 = On
0 being replaced by the state number 0 ~ 1:
nipovrd:0
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
#define MESH_ROOTALT "Kemono Body"
// TODO: Remove entries that have the same values
// TODO: Implement overridable faces and finish separating stock and fitted torso associations
list names_assoc = [API_CMD_ANKLE_L, API_CMD_ANKLE_R,
                                     API_CMD_CALF_L, API_CMD_CALF_R, API_CMD_KNEE_L, API_CMD_KNEE_R,
                                     API_CMD_SHIN_L_L, API_CMD_SHIN_L_R, API_CMD_ABS, API_CMD_ARM_L_L,
                                     API_CMD_ARM_L_R, API_CMD_ARM_U_L, API_CMD_ARM_U_R, API_CMD_BELLY,
                                     MESH_BODY, API_CMD_ELBOW_L, API_CMD_ELBOW_R, API_CMD_FOOT_L,
                                     API_CMD_FOOT_R, MESH_HAND_LEFT, MESH_HAND_RIGHT, API_CMD_SHIN_U_L,
                                     API_CMD_SHIN_U_R, API_CMD_SHOULDER_L_L, API_CMD_SHOULDER_U_R,
                                     API_CMD_THIGH_U_R, API_CMD_WRIST_L,
                                     API_CMD_WRIST_R];
list faces_assoc = [5, 5, 4, 4, 1, 1, 4, 4, "6,7", 7, 2, 0, 6, "2,3", 0, 4, 5,
                       0, 0, -1, -1, 3, 3, 3, 4, 4, 3, 1];
list faceshumanmode = [1, 1, 2, 2, 5, 5, 2, 2];
#define MESH_SK_NIPS "nips"
#define MESH_SK_VAGOO "vagoo"
// Piercings
#define MESH_DERMAL_BACK0 "Triple Back Dimple Dermals0"
#define MESH_DERMAL_BACK1 "Triple Back Dimple Dermals1"
#define MESH_DERMAL_BACK2 "Triple Back Dimple Dermals2"
#define MESH_DERMAL_HIPS0 "Triple Hip Bone Dermals0"
#define MESH_DERMAL_HIPS1 "Triple Hip Bone Dermals1"
#define MESH_DERMAL_HIPS2 "Triple Hip Bone Dermals2"
#define MESH_DERMAL_CLLR0 "Triple Collar Bone Dermals0"
#define MESH_DERMAL_CLLR1 "Triple Collar Bone Dermals1"
#define MESH_DERMAL_CLLR2 "Triple Collar Bone Dermals2"
#define MESH_BELLY_RING0 "Belly Ring"
#define MESH_NIPPLE_RING0 "Busty Nipple Rings"
// #define MESH_NIPPLE_RING1 ""
// #define MESH_NIPPLE_RING2 ""
#define MESH_NIPPLE_LOOP0 "Busty Nipple Loops"
// #define MESH_NIPPLE_LOOP1 ""
// #define MESH_NIPPLE_LOOP2 ""
#define MESH_NIPPLE_BARB0 "Busty Nipple Barbells"
// #define MESH_NIPPLE_BARB1 ""
// #define MESH_NIPPLE_BARB2 ""
#define MESH_VAGINA_CLIT0 "Clit Ring"
// #define MESH_VAGINA_CLIT1 ""
// #define MESH_VAGINA_CLIT2 ""
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
MESH_ROOT,\
MESH_ROOTALT\
]
// These go above. Can't comment out defined list parts.
/*MESH_DERMAL_BACK0,\*/
/*MESH_DERMAL_BACK1,\*/
/*MESH_DERMAL_BACK2,\*/
/*MESH_DERMAL_HIPS0,\*/
/*MESH_DERMAL_HIPS1,\*/
/*MESH_DERMAL_HIPS2,\*/
/*MESH_DERMAL_CLLR0,\*/
/*MESH_DERMAL_CLLR1,\*/
/*MESH_DERMAL_CLLR2,\*/
/*MESH_NIPPLE_RING0,\*/
/*MESH_NIPPLE_LOOP0,\*/
/*MESH_NIPPLE_BARB0,\*/
/*MESH_VAGINA_CLIT0,\*/
/*MESH_BELLY_RING0,\*/
#define s_FittedNipsMeshNames [\
MESH_FITTED_TORSO_NIP_0,/* 0, visible: PG mesh, hidden: ALpha stage 2*/\
MESH_FITTED_TORSO_ETC,/* 1 */\
MESH_FITTED_TORSO_NIP_1, /* 2 */\
MESH_FITTED_TORSO_NIP_A /* alpha stage 1 */\
]
#define s_KFTPelvisMeshes [\
"BitState0",\
"BitState1",\
"BitState2",\
"BitState3"\
]
integer s_KFTPelvisMeshes_size = 0;
//#define s_NipplePiercingsNames [\
//MESH_NIPPLE_RING0,\
//MESH_NIPPLE_LOOP0,\
//MESH_NIPPLE_BARB0\
//]
//#define s_VaginalPiercingsNames [\
//MESH_VAGINA_CLIT0\
//]
#define FKT_PRESENT 1
#define HUMAN_LEGS 2
/* PG States */
#define KSB_PGNIPLS 4
#define KSB_PGVAGOO 8
#define KSB_HDBRSTS 16
//#define RESERVED 32
//#define RESERVED 64
//#define RESERVED 128
//#define RESERVED 256
//#define RESERVED 512
//#define RESERVED 1024
//#define RESERVED 2048
/* Flags for blade sync purposes*/
#define STARBRIGHT_FKT_HUD_BUTT 134217727
#define STARBRIGHT_FKT_HUD_NIPS 268435455
#define STARBRIGHT_FKT_HUD_VAGN 536870911
#define STARBRIGHT_FKT_HUD_NIPH 1073741824
/* Some shorthand operators are not allowed in LSL, so let's do some hackery
usage:
a=variable/set
b=bit (define, see above)
Reminder: All LSL integers are 32 Bits-wide. This means the data we have to
play with is:
0000 0000 0000 0000 0000 0000 0000 0000
ie 00000000000000000000000000000010 = 2
The maximum value we can store is:
- 31 booleans, or bits. (-1 for sign)
- 1073741824
- 10000000000000000000000000000000
The increment is by base 2, so: 0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
and so on...
*/
#define bwChange(a,b,c) a=(a & (~b)) | (b * c)
#define bwClear(a,b) a=(a & (~b))
#define bwGet(a,b) a & b
#define bwSet(a,b) a=(a | b)
/* Why can't we just do "a ^= b"? It's
more succinct but it just won't compile that way. So
"a = a ^ b" (old school) will
have to do instead. Anyway, toggle using XOR..
*/
#define bwToggle(a,b) a=a ^ b
#define llGetListSize(a) ((llGetListLength(a))-1)
#define compiled_name "xenhat.kemono.body.lsl"
#define g_internal_repo_s "XenHat/"+script_name
#define script_name "Kemono-Body-Script"
/* TODO: Use a bitset if we run out of memory */
#define g_DefaultFittedButState 1
#define g_DefaultFittedNipAlpha 0
#define g_DefaultFittedNipState 1
#define g_DefaultFittedVagState 1
integer g_CurrentFittedButState = 1;
integer g_CurrentFittedNipState = 1;
integer g_CurrentFittedNipAlpha = 0;
integer g_CurrentFittedVagState = 1;
// integer g_PreviousFittedButState=1;
integer g_PreviousFittedNipState = 1;
// integer g_PreviousFittedNipAlpha=0;
// integer g_PreviousFittedVagState=1;
integer g_HasAnimPerms = FALSE;
integer g_RuntimeBodyStateSettings;
// integer g_TogglingPGMeshes=FALSE;
integer human_mode = TRUE; /* Prefer when available*/
key g_Owner_k;
key g_Last_k;
list g_LinkDB_l = [];
list g_AttmntAuthedKeys_l;
string g_LastCommand_s;
/* Overridable deform animation */
string g_AnimDeform;
string g_AnimUndeform;
#define xlStartAnimation(name) { \
  llStartAnimation(name);\
}
list xlGetFacesByBladeName(string name)
{
#ifdef NEW_ASSOC_LOGIC
  integer index = llListFindList(names_assoc, [name]);

  if(index > -1) {
    string f = llList2String(faces_assoc, index);

    if(f) {
      // llOwnerSay("Optimized call for " + name);
      // return llParseString2List(f, [","], []);
      return llCSV2List(f);
    }
  }

  // llOwnerSay("Falling back to old method for: " + name);
#endif

  if(name == API_CMD_ABS) {
    return [6, 7];
  }

  if(name == API_CMD_ANKLE_L) {
    if(human_mode) {
      return [1];
    }

    return [5];
  }

  if(name == API_CMD_ANKLE_R) {
    if(human_mode) {
      return [1];
    }

    return [5];
  }

  if(name == API_CMD_ARM_L_L) {
    return [7];
  }

  if(name == API_CMD_ARM_L_R) {
    return [2];
  }

  if(name == API_CMD_ARM_U_L) {
    return [0];
  }

  if(name == API_CMD_ARM_U_R) {
    return [6];
  }

  if(name == API_CMD_BELLY) {
    return [2, 3];
  }

  if(name == MESH_BODY) {
    return [0];
  }

  if(name == API_CMD_BREASTS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [2, 3];
    }

    return [2, 5];
  }

  if(name == API_CMD_CALF_L) {
    if(human_mode) {
      return [4];
    }

    return [2];
  }

  if(name == API_CMD_CALF_R) {
    if(human_mode) {
      return [4];
    }

    return [2];
  }

  if(name == API_CMD_CHEST) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [0, 1];
    }

    return [0, 4];
  }

  if(name == API_CMD_COLLAR) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [6, 7];
    }

    return [1, 6];
  }

  if(name == API_CMD_ELBOW_L) {
    return [4];
  }

  if(name == API_CMD_ELBOW_R) {
    return [5];
  }

  if(name == API_CMD_FOOT_L) {
    return [0];
  }

  if(name == API_CMD_FOOT_R) {
    return [0];
  }

  if(name == API_CMD_HIP_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [5];
    }

    return [6];
  }

  if(name == API_CMD_HIP_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [4];
    }

    return [5];
  }

  if(name == API_CMD_KNEE_L) {
    if(human_mode) {
      return [5];
    }

    return [1];
  }

  if(name == API_CMD_KNEE_R) {
    if(human_mode) {
      return [5];
    }

    return [1];
  }

  if(name == MESH_HAND_LEFT) {
    return [-1];
  }

  if(name == MESH_HAND_RIGHT) {
    return [-1];
  }

  if(name == MESH_NECK) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [0, 1];
    }

    return [2, 5];
  }

  if(name == MESH_SK_NIPS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT))
      /* Note: Before changing this again, create a different way of
      handling the request that doesn't match.
      This is configured properly for the whole Fitted Torso chest mesh
      */
    {
      return [0, 1];
    }

    return [2, 3];
  }

  if(name == API_CMD_PELVIS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [0, 1, 2, 3];
    }

    return [0, 1];
  }

  if(name == API_CMD_RIBS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [4, 5];
    }

    return [1, 3];
  }

  if(name == API_CMD_SHIN_L_L) {
    if(human_mode) {
      return [2];
    }

    return [4];
  }

  if(name == API_CMD_SHIN_L_R) {
    if(human_mode) {
      return [2];
    }

    return [4];
  }

  if(name == API_CMD_SHIN_U_L) {
    return [3];
  }

  if(name == API_CMD_SHIN_U_R) {
    return [3];
  }

  if(name == API_CMD_SHOULDER_L_L) {
    return [3];
  }

  if(name == API_CMD_SHOULDER_L_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [2];
    }

    return [0];
  }

  if(name == API_CMD_SHOULDER_U_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [5];
    }

    return [7];
  }

  if(name == API_CMD_SHOULDER_U_R) {
    return [4];
  }

  if(name == API_CMD_THIGH_L_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      if(human_mode) {
        return [1];
      }

      return [7];
    }

    return [6];
  }

  if(name == API_CMD_THIGH_L_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      if(human_mode) {
        return [0];
      }

      return [6];
    }

    return [6];
  }

  if(name == API_CMD_THIGH_U_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [5];
    }

    return [7];
  }

  if(name == API_CMD_THIGH_U_R) {
    return [4];
  }

  if(name == API_CMD_VAG) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      /* Reminder: On the Fitted Torso, this is the upper hip mesh half.
      The bottom hip mesh half is controlled independently using
      setbutt
      */
      // if(g_TogglingPGMeshes)
      // return [0,1,2,3,4,5];
      return [0, 1];
    }

    return [0, 1];
  }

  if(name == API_CMD_VIRTUAL_BUTT) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      /* Reminder: On the Fitted Torso, this is the upper hip mesh half.
      The bottom hip mesh half is controlled independently using
      setbutt
      */
      //if(g_TogglingPGMeshes)
      //  return [0,1,2,3,4,5];
      return [2, 3, 4, 5];
    }

    return [];
  }

  if(name == API_CMD_WRIST_L) {
    return [3];
  }

  if(name == API_CMD_WRIST_R) {
    return [1];
  }

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
list xlBladeNameToPrimNames(string name)
{
  /* TODO Can't we return the link number directly (using less than 512 bytes
  of code!) without an additional function call?
  */
  if(name == API_CMD_ARM_L_L) {
    return [MESH_ARMS];

  } else if(name == API_CMD_ARM_L_R) {
    return [MESH_ARMS];

  } else if(name == API_CMD_ARM_U_L) {
    return [MESH_ARMS];

  } else if(name == API_CMD_ARM_U_R) {
    return [MESH_ARMS];

  } else if(name == API_CMD_ELBOW_L) {
    return [MESH_ARMS];

  } else if(name == API_CMD_ELBOW_R) {
    return [MESH_ARMS];

  } else if(name == API_CMD_WRIST_L) {
    return [MESH_ARMS];

  } else if(name == API_CMD_WRIST_R) {
    return [MESH_ARMS];

  } else if(name == API_CMD_RIBS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_CHEST];
    }

    return [MESH_BODY];

  } else if(name == API_CMD_ABS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_CHEST];
    }

    return [MESH_BODY];

  } else if(name == MESH_BODY) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_CHEST];
    }

    return [MESH_BODY];

  } else if(name == API_CMD_BREASTS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_CHEST];
    }

    return [MESH_BODY];

  } else if(name == API_CMD_CHEST) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_CHEST];
    }

    return [MESH_BODY];

  } else if(name == API_CMD_COLLAR) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO];
    }

    return [MESH_NECK];

  } else if(name == MESH_HAND_LEFT) {
    return [MESH_HAND_LEFT];

  } else if(name == MESH_HAND_RIGHT) {
    return [MESH_HAND_RIGHT];

  } else if(name == API_CMD_HIP_L || name == API_CMD_HIP_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [llList2String(s_KFTPelvisMeshes, g_CurrentFittedVagState)];
    }

    return [MESH_HIPS];

  } else if(name == MESH_NECK) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO];
    }

    return [MESH_NECK];

  } else if(name == API_CMD_PELVIS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [llList2String(s_KFTPelvisMeshes, g_CurrentFittedVagState)];
    }

    return [MESH_HIPS];

  } else if(name == API_CMD_KNEE_R) {
    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_FOOT_R) {
    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_ANKLE_R) {
    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_SHIN_U_R) {
    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_CALF_R) {
    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_SHIN_L_R) {
    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_CALF_L) {
    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

    return [MESH_LEG_LEFT_ANIMAL];

  } else if(name == API_CMD_ANKLE_L) {
    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

    return [MESH_LEG_LEFT_ANIMAL];

  } else if(name == API_CMD_FOOT_L) {
    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

    return [MESH_LEG_LEFT_ANIMAL];

  } else if(name == API_CMD_KNEE_L) {
    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

    return [MESH_LEG_LEFT_ANIMAL];

  } else if(name == API_CMD_SHIN_L_L) {
    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

    return [MESH_LEG_LEFT_ANIMAL];

  } else if(name == API_CMD_SHIN_U_L) {
    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

    return [MESH_LEG_LEFT_ANIMAL];

  } else if(name == API_CMD_SHOULDER_L_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO];
    }

    return [MESH_NECK];

  } else if(name == API_CMD_SHOULDER_L_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO];
    }

    return [MESH_NECK];

  } else if(name == API_CMD_SHOULDER_U_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO];
    }

    return [MESH_NECK];

  } else if(name == API_CMD_SHOULDER_U_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO];
    }

    return [MESH_NECK];

  } else if(name == API_CMD_THIGH_U_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_ETC];
    }

    return [MESH_HIPS];

  } else if(name == API_CMD_THIGH_U_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_ETC];
    }

    return [MESH_HIPS];

  } else if(name == API_CMD_BELLY) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_ETC];
    }

    return [MESH_HIPS];

  } else if(name == MESH_SK_NIPS) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      if(1 == g_CurrentFittedNipAlpha) {
        /* nip alpha stage 1 */
        return [MESH_FITTED_TORSO_NIP_A];

      } else if(2 == g_CurrentFittedNipAlpha) {
        /*  nip alpha stage 2 */
        return [MESH_FITTED_TORSO_NIP_0];

      } else {
        return [llList2String(s_FittedNipsMeshNames,
                              g_CurrentFittedNipState)];
      }
    }

    return [MESH_PG_LAYER];

  } else if(name == MESH_FITTED_TORSO_NIP_A) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      return [MESH_FITTED_TORSO_NIP_A];
    }

    return [MESH_PG_LAYER];

  } else if(name == API_CMD_VAG) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      //if(g_TogglingPGMeshes)
      //  return [llList2String(s_KFTPelvisMeshes,0)];
      return [llList2String(s_KFTPelvisMeshes, g_CurrentFittedVagState)];
    }

    return [MESH_PG_LAYER];

  } else if(name == API_CMD_THIGH_L_R) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      if(human_mode) {
        return [MESH_FITTED_TORSO_HLEGS];
      }

      return [MESH_FITTED_TORSO_ETC];
    }

    if(human_mode) {
      return [MESH_LEG_RIGHT_HUMAN];
    }

    return [MESH_LEG_RIGHT_ANIMAL];

  } else if(name == API_CMD_THIGH_L_L) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      if(human_mode) {
        return [MESH_FITTED_TORSO_HLEGS];
      }

      return [MESH_FITTED_TORSO_ETC];
    }

    if(human_mode) {
      return [MESH_LEG_LEFT_HUMAN];
    }

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
xlProcessCommandWrapper()
{
  if(g_LastCommand_s == KM_HUD_RESET_CMD) {
    reset();

  } else if(g_LastCommand_s == "resetA") {
    reset();

  } else if(g_LastCommand_s == "resetB") {
    g_AttmntAuthedKeys_l = [];
    reset();

  } else if(g_LastCommand_s == "Hlegs") {
#ifdef PROCESS_LEGS_COMMANDS
    // if(!human_mode) {
    human_mode = FALSE;
    g_LastCommand_s =
      "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
    // }
    human_mode = TRUE;
    g_LastCommand_s =
      "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
#endif
    saveSettings();

  } else if(g_LastCommand_s == "Flegs") {
#ifdef PROCESS_LEGS_COMMANDS
    // if(human_mode) {
    human_mode = TRUE;
    g_LastCommand_s =
      "hide:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
    // }
    human_mode = FALSE;
    g_LastCommand_s =
      "show:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR";
    xlProcessCommand(TRUE);
#endif
    saveSettings();
  }

  /* TODO: FIXME: Kind of brutal, should probably store the last hand anim or something.*/
  /* TODO: move all this below inside the command processor */
  else if(g_LastCommand_s == "Rhand:1") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-R-relax");
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-point");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:2") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:3") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:4") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Rhand:5") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-R-horns");
      llStopAnimation("Kem-hand-R-fist");
      llStopAnimation("Kem-hand-R-hold");
      llStopAnimation("Kem-hand-R-point");
      llStopAnimation("Kem-hand-R-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:1") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-L-relax");
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-point");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:2") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:3") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:4") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if(g_LastCommand_s == "Lhand:5") {
    if(g_HasAnimPerms) {
      xlStartAnimation("Kem-hand-L-horns");
      llStopAnimation("Kem-hand-L-fist");
      llStopAnimation("Kem-hand-L-hold");
      llStopAnimation("Kem-hand-L-point");
      llStopAnimation("Kem-hand-L-relax");
    }

    return;

  } else if("reqFTdat" == g_LastCommand_s) {
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
      // Example: resFTdat:nipState:0:nipAlpha:0:nipOvrd:1:vagState:0:buttState:0:humLegs:0
      // resFTdat:nipState:" + (string)nipState + ":nipAlpha:" + (string)nipAlpha + ":nipOvrd:" + (string)nipOvrd +
      // ":vagState:" + (string)vagState + ":buttState:" + (string)buttState + ":humLegs:" + (string)humLegs)
      llRegionSayTo(g_Owner_k, KEMONO_COM_CH, "resFTdat:nipState:"
                    + (string)g_CurrentFittedNipState
                    + ":nipAlpha:" + (string)g_CurrentFittedNipAlpha
                    + ":nipOvrd:0" /* TODO: Implement Nipple Override */
                    + ":vagState:" + (string)g_CurrentFittedVagState
                    + ":buttState:" + (string)g_CurrentFittedButState
                    + ":humLegs:" + (string)human_mode);
    }

    return;

  } else {
#ifdef FTK_MULTI_DROP

    /* Ignore Starbright's Kemono Torso messages when handling that mesh*/
    if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT))
      if(llSubStringIndex(name, MESH_FITTED_TORSO) > 3) {
        return;
      }

#endif

    if(llSubStringIndex(g_LastCommand_s, "resCLdat") == 0) {
      /* This API isn't public, the best we can do is guess. */
      if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
        list data = llParseString2List(g_LastCommand_s, [":"], []);
        /* ie 'resCLdat:clothID:1064:clothDesc:Top:attachPoint:30:clothState:2' */
        /* resCLdat:clothID:1003:clothDesc:Jeans:attachPoint:28:clothState:0' <= Starbright Fitted Jeans */
        /* integer clothID = llList2Integer(data,2); */
        string clothDesc = llList2String(data, 4);
        // integer attachPoint = llList2Integer(data,6);
        integer clothState = llList2Integer(data, 8); /*0:on, 1: pulled, 2: removed*/

        /* TODO: Treat clothState0 as PG enabled UNLESS it's a special clothing
        with transparent/exposed nips. God knows how I'm going to figure that
        one out.
        */
        /* NOTE: This is part of the internal Starbright API. We shouldn't know
        how to handle this and that is fine. Staryna says it's for
        careful ordering of stuff. Private and all.
        However some commands are required to be handled here to ensure
        clothing made for the FKT behave properly
        */
        if("Top" == clothDesc) {
          // Restore previous genital state
          if(0 == clothState) {
            //g_CurrentFittedNipState=g_FKT_stored_nipstate;
            // force visible for now ok?
            //g_CurrentFittedNipAlpha=1;
            // g_LastCommand_s="setnip:"+(string)g_PreviousFittedNipState;
            // xlProcessCommand(TRUE);
          } else {
            // store genital state
            g_PreviousFittedNipState = g_CurrentFittedNipState;
          }
        }

        // else if("Jeans"==clothDesc) {
        //  //if(0==clothState) {
        //  //  // Adjust to clothing perhaps? Find out what this does normally.
        //  //  //g_CurrentFittedVagState=???
        //  //  //g_CurrentFittedButState=???
        //  //} else { /* if(1==clothState) */
        //  //}
        //}
      }

      return;
    }

    xlProcessCommand(TRUE);
  }
}
xlProcessCommand(integer send_params)
{
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
  list input_data = llParseString2List(g_LastCommand_s, [":"], []);
  string command = llList2String(input_data, 0);
  integer list_size = llGetListLength(input_data);
  integer index = 0;
  integer i_make_visible = -1;
  list local_params;
  integer mesh_count_index = 0;
  /* Official commands present in the retail Kemono body */
#define CMD_BODYCORE 2
  /* Unofficial commands added by mod creators */
#define CMD_IS_MOD_HIJACK 4
  integer mod_command = -1;
  integer mod_command_2 = -1;

  for(; index < list_size ; index++) {
    command = llList2String(input_data, index);

    /* evaluate non-standard commands before looping through stock api */
    if(0 == index/*-1==i_make_visible*/) {
      if("setnip" == command) {
        // Completely ignore nipple changes if alpha mode is on
        //if(g_CurrentFittedNipAlpha)
        {
          mesh_count_index = llGetListSize(s_FittedNipsMeshNames);
          mod_command = STARBRIGHT_FKT_HUD_NIPS;
          mod_command_2 = CMD_IS_MOD_HIJACK;
        }

      } else if("nipalpha" == command) {
        mesh_count_index = llGetListSize(s_FittedNipsMeshNames);
        mod_command = STARBRIGHT_FKT_HUD_NIPH;
        mod_command_2 = CMD_IS_MOD_HIJACK;

      } else if("setbutt" == command) {
        mesh_count_index = s_KFTPelvisMeshes_size;
        mod_command = STARBRIGHT_FKT_HUD_BUTT;
        mod_command_2 = CMD_IS_MOD_HIJACK;

      } else if("setvag" == command) {
        mesh_count_index = s_KFTPelvisMeshes_size;
        mod_command_2 = CMD_IS_MOD_HIJACK;
        mod_command = STARBRIGHT_FKT_HUD_VAGN;

      } else if("show" == command) {
        i_make_visible = TRUE;

      } else if("hide" == command) {
        i_make_visible = FALSE;

      } else if("remove" == command) {
        /* Object signals they no longer need to talk with the API;
        Remove their key from the list of authorized attachments.
        This object will need to use the 'add' command
        to interact with us again
        */
        integer placeinlist = llListFindList(g_AttmntAuthedKeys_l, [g_Last_k]);

        if(placeinlist != -1) {
          g_AttmntAuthedKeys_l = llDeleteSubList(g_AttmntAuthedKeys_l,
                                                 placeinlist, placeinlist);
        }

      } else if(llSubStringIndex(command, "color*<") != -1) {
        g_Config_BladeColor = (vector)llGetSubString(command, 6, -1);
      }

      /* Add more commands here */
#ifdef PRINT_UNHANDLED_COMMANDS
#define nope ["tail","skin","FTExpReq","bitEditState","add","reqCLdat","clothState","FTExp01","FTExp02","FTExp03" /* not here! */\
        ,"eSize", "eRoll", "Anim", "LEye", "REye", "Exp", "Lash", "Brows", "FLight" /* Kemono M3 Head */]
      else if(llListFindList(nope, [command]) == -1)
        //llOwnerSay("Unhandled command '" + command + "' from " + llKey2Name(g_Last_k));
#endif

      } else {
      /* non-standard command done or unhandled, and/or show/hide set,
      loop through the remaining parameters
      */
      if(mod_command < 1) {
        /* We need to identify these commands as genital commands
        otherwise they will be processed incorrectly in the
        non-genitals code path
        */
        if(API_CMD_NIPS == command) {
          /* FIXME: Do not use the "core" code path when using mods
          as it will not toggle the other required faces
          */
          bwChange(g_RuntimeBodyStateSettings, KSB_PGNIPLS, !i_make_visible);

          if(bwGet(g_RuntimeBodyStateSettings, KSB_HDBRSTS)) {
            /* Don't do anything beyond keeping track of the state it should
            be. This is stock behaviour.
            */
            return;
          }

          if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
            mod_command = KSB_PGNIPLS;
            mod_command_2 = CMD_IS_MOD_HIJACK;

          } else {
            mod_command = KSB_PGNIPLS;
            mod_command_2 = CMD_BODYCORE;
          }

        } else if(API_CMD_VAG == command) {
          mod_command = KSB_PGVAGOO;
          mod_command_2 = CMD_BODYCORE;
          bwChange(g_RuntimeBodyStateSettings, KSB_PGVAGOO, !i_make_visible);

        } else {
          mod_command_2 = CMD_BODYCORE;
        }
      }

      if(CMD_IS_MOD_HIJACK == mod_command_2) {
        integer param = llList2Integer(input_data, index);
        string mesh_name = "";

        for(; mesh_count_index > -1; mesh_count_index--) {
          /* Mods */
          /* TODO: Use preprocessor-able checks to hard-code mods
          for released compiled scripts*/
          /*#ifndef SB_FKT*/
          /* Standard Kemono API stuff */
          //if(KSB_PGNIPLS==mod_command)
          //{
          //
          //  mesh_name=(string)xlBladeNameToPrimNames(MESH_SK_NIPS);
          //}
          //#else
          if(KSB_PGNIPLS == mod_command) {
            /* Pretend this is a FKT hud command because that logic
            already exists
            */
            // mod_command=STARBRIGHT_FKT_HUD_NIPS;
            g_LastCommand_s = "setnip:" + (string)i_make_visible;
            xlProcessCommand(TRUE);
          }

          if(STARBRIGHT_FKT_HUD_NIPH == mod_command) {
            g_CurrentFittedNipAlpha = param;
            mesh_name = llList2String(s_FittedNipsMeshNames, mesh_count_index);
            // mesh_name=MESH_FITTED_TORSO_NIP_A;
            i_make_visible = (g_CurrentFittedNipAlpha == 1) * (mesh_count_index == 3);

            /* TODO: Properly implement:
            Stage0 hides the alpha mesh, and shows TorsoEtc/PG meshes
            Stage1 shows the alpha mesh AND hides the PG mesh
            Stage2 hides the alpha mesh AND hides the PG mesh.
            */
            if(0 == param) {
              mod_command = STARBRIGHT_FKT_HUD_NIPS;
              // TODO: restore previous nip state
              param = g_PreviousFittedNipState;

            } else {
              g_PreviousFittedNipState = g_CurrentFittedNipState;
            }
          }

          if(STARBRIGHT_FKT_HUD_NIPS == mod_command) {
            g_CurrentFittedNipState = param;

            if(!g_CurrentFittedNipAlpha) {
              {
                i_make_visible =/*!g_CurrentFittedNipAlpha *
                !bwGet(g_RuntimeBodyStateSettings,mod_command) */
                  (mesh_count_index == g_CurrentFittedNipState);
                mesh_name = llList2String(s_FittedNipsMeshNames, mesh_count_index);
              }
            }

            //else
            //{
            //
            //  i_make_visible=FALSE;
            //}

          } else if(STARBRIGHT_FKT_HUD_VAGN == mod_command) {
            g_CurrentFittedVagState = param;
            i_make_visible = /*!bwGet(g_RuntimeBodyStateSettings,mod_command) **/
              (mesh_count_index == param);
            mesh_name = llList2String(s_KFTPelvisMeshes, mesh_count_index);

          } else if(STARBRIGHT_FKT_HUD_BUTT == mod_command) {
            g_CurrentFittedButState = param;
            i_make_visible = /*!bwGet(g_RuntimeBodyStateSettings,mod_command) */
              (mesh_count_index == param);
            mesh_name = llList2String(s_KFTPelvisMeshes, mesh_count_index);
          }

          /* TODO: Handle overrides (PG, etc) since bitwise check
          is removed */
          if(llStringLength(mesh_name) > 0) {
            /* FIXME: PG nipple state briefly shows up mid-loop */
            list prim_names = xlBladeNameToPrimNames(mesh_name);
            integer link_id = llList2Integer(g_LinkDB_l,
                                             llListFindList(g_LinkDB_l, prim_names) + 1);
            local_params += [PRIM_LINK_TARGET, link_id];
            //
            list faces_l = [];

            if(STARBRIGHT_FKT_HUD_NIPS == mod_command || KSB_PGNIPLS == mod_command) {
              faces_l = xlGetFacesByBladeName(MESH_SK_NIPS);

            } else if(STARBRIGHT_FKT_HUD_VAGN == mod_command) {
              faces_l = xlGetFacesByBladeName(API_CMD_VAG);

            } else if(STARBRIGHT_FKT_HUD_NIPH == mod_command) {
              faces_l = xlGetFacesByBladeName(MESH_SK_NIPS);

            } else if(STARBRIGHT_FKT_HUD_BUTT == mod_command) {
              faces_l = xlGetFacesByBladeName(API_CMD_VIRTUAL_BUTT);
            }

            integer faces_count = llGetListLength(faces_l);
            integer i2 = 0;

            for(; i2 < faces_count; i2++) {
              local_params += [PRIM_COLOR,
                               llList2Integer(faces_l, i2), g_Config_BladeColor,
                               i_make_visible * g_Config_MaximumOpacity
                              ];
            }
          }
        }

      } else if(CMD_BODYCORE == mod_command_2) {
        list prim_names = xlBladeNameToPrimNames(command);
        /* TODO: Be less nuclear and only fix the faces we asked for*/
        /* TODO: inline as much as possible */
        local_params += [
                          PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                              llListFindList(g_LinkDB_l, prim_names) + 1)
                        ];
        list faces_l = xlGetFacesByBladeName(command);
        integer faces_index = llGetListSize(faces_l);

        for(; faces_index > -1; faces_index--) {
          local_params += [
                            PRIM_COLOR, llList2Integer(faces_l, faces_index), g_Config_BladeColor,
                            (i_make_visible) *
                            g_Config_MaximumOpacity
                          ];
        }

        if(API_CMD_BREASTS == command /*API_CMD_NIPS==command*/) {
          /* Manually hard-code this one for speed and simplicity*/
          if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
            bwChange(g_RuntimeBodyStateSettings, KSB_HDBRSTS, !i_make_visible);
            list faces = xlGetFacesByBladeName(MESH_SK_NIPS);
            list snd_lvl_params = [
                                    // PG meshes
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [MESH_FITTED_TORSO_NIP_0]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 0
                                        || (bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                       ),
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible
                                    && (g_CurrentFittedNipState == 0
                                        || (bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                       ),
                                    // nipple meshes
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [MESH_FITTED_TORSO_ETC]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 1
                                    && !(bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 1
                                    && !(bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [MESH_FITTED_TORSO_NIP_1]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 2
                                    && !(bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible
                                    && g_CurrentFittedNipState == 2
                                    && !(bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                    && g_CurrentFittedNipAlpha < 1,
                                    PRIM_LINK_TARGET, llList2Integer(g_LinkDB_l,
                                        llListFindList(g_LinkDB_l, [MESH_FITTED_TORSO_NIP_A]) + 1),
                                    PRIM_COLOR, llList2Integer(faces, 1), g_Config_BladeColor,
                                    i_make_visible && g_CurrentFittedNipAlpha > 0
                                    && !(bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS)),
                                    PRIM_COLOR, llList2Integer(faces, 0), g_Config_BladeColor,
                                    i_make_visible && g_CurrentFittedNipAlpha > 0
                                    && !(bwGet(g_RuntimeBodyStateSettings, KSB_PGNIPLS))
                                  ];
            local_params += snd_lvl_params;
          }
        }
      }
    }
  }

  /* Send params to prim now */
  if(send_params) {
    xlSetLinkPrimitiveParamsFast(LINK_ROOT, local_params);
    local_params = [];
  }
}
resetHands()
{
  if(g_HasAnimPerms) {
    xlStartAnimation("Kem-hand-R-relax");
    xlStartAnimation("Kem-hand-L-relax");
    llStopAnimation("Kem-hand-L-fist");
    llStopAnimation("Kem-hand-L-hold");
    llStopAnimation("Kem-hand-L-horns");
    llStopAnimation("Kem-hand-L-point");
    llStopAnimation("Kem-hand-R-fist");
    llStopAnimation("Kem-hand-R-hold");
    llStopAnimation("Kem-hand-R-horns");
    llStopAnimation("Kem-hand-R-point");
    xlStartAnimation(g_AnimDeform);
    llStopAnimation(g_AnimUndeform);
  }
}
reset()
{
  if(bwGet(g_RuntimeBodyStateSettings, FKT_PRESENT)) {
    // g_LastCommand_s = ":nipalpha:" + (string)g_DefaultFittedNipAlpha;
    // xlProcessCommand(FALSE);
    g_LastCommand_s = ":setnip:" + (string)g_DefaultFittedNipState + ":setnip:" +
                      (string)g_DefaultFittedNipState;
    xlProcessCommand(TRUE);
  }

  g_LastCommand_s = KM_HUD_RESET_CMD;
  xlProcessCommand(TRUE);
  resetHands();
}
detectLinkSetMods()
{
  g_LinkDB_l = [];
#ifdef DEBUG_ENTIRE_BODY_ALPHA
  string texture = llGetInventoryName(INVENTORY_TEXTURE, 0);
  integer retexture = texture != "";
  list prim_params_to_apply = [];
#endif
  integer part = llGetNumberOfPrims();
  integer found_fitted_torso = FALSE;

  for(; part > 0; --part) {
    string name = llGetLinkName(part);

    if(!found_fitted_torso) {
      if(name == API_CMD_FITTED_TORSO) {
        /* Shortcut if previously renamed */
        found_fitted_torso = TRUE;
        name = MESH_FITTED_TORSO;

      } else if(llSubStringIndex(name, "Kemono") != -1 &&
                llSubStringIndex(name, "Torso") != -1 &&
                (llSubStringIndex(name, "Petite") != -1 ||
                 llSubStringIndex(name, "Busty") != -1)) {
        found_fitted_torso = TRUE;
        llSetLinkPrimitiveParams(part, [PRIM_NAME, API_CMD_FITTED_TORSO]);
        name = MESH_FITTED_TORSO;
      }
    }

    if(llListFindList(g_supported_meshes, [name]) != -1) {
#ifdef DEBUG_ENTIRE_BODY_ALPHA
      prim_params_to_apply += [
                                PRIM_LINK_TARGET, part, PRIM_COLOR, ALL_SIDES, g_Config_BladeColor, 0.0
                              ];

      if(retexture) {
        prim_params_to_apply += [
                                  PRIM_TEXTURE, ALL_SIDES, texture, <1, 1, 0>, <0, 0, 0>, 0.0
                                ];
      }

#endif
      g_LinkDB_l += [name, part];
    }
  }

  if(found_fitted_torso) {
    bwSet(g_RuntimeBodyStateSettings, FKT_PRESENT);
    g_LastCommand_s = "setbutt:" + (string)g_CurrentFittedButState;
    xlProcessCommand(TRUE);
    g_LastCommand_s = "setnip:" + (string)g_CurrentFittedNipState;
    xlProcessCommand(TRUE);
    g_LastCommand_s = "setvag:" + (string)g_CurrentFittedVagState;
    xlProcessCommand(TRUE);
    g_LastCommand_s = "nipalpha:" + (string)g_CurrentFittedNipAlpha;
    xlProcessCommand(TRUE);
  }

#ifdef DEBUG_ENTIRE_BODY_ALPHA
  llSetLinkPrimitiveParamsFast(LINK_ROOT, prim_params_to_apply);
#endif
#ifdef DEBUG_SELF_TEST
  g_LastCommand_s = "hide:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
                    + "shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
                    + "thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
                    + "shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
                    + "elbowR:armLL:armLR:wristL:wristR:handL:handR";
  xlProcessCommand(TRUE);
  llSleep(0.25);
  g_LastCommand_s = "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
                    + "shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
                    + "thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
                    + "shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
                    + "elbowR:armLL:armLR:wristL:wristR:handL:handR";
  llSleep(0.25);
  xlProcessCommand(TRUE);
  list selftest = ["neck", "shoulderUL", "shoulderUR", "collar", "shoulderLL",
                           "shoulderLR", "armUL", "armUR", "chest", "breast", "elbowL", "elbowR",
                           "ribs", "armLL", "armLR", "abs", "wristL", "wristR", "belly", "handL", "handR",
                           "pelvis", "hipL", "hipR", "thighUL", "thighUR", "thighLL",
                           "thighLR", "kneeL", "kneeR", "calfL", "calfR", "shinUL", "shinUR",
                           "shinLL", "shinLR", "ankleL", "ankleR", "footL", "footR"];
  integer id = 0;
  integer len = llGetListLength(selftest);

  for(; id < len; ++id) {
    g_LastCommand_s = "hide:" + llList2String(selftest, id);
    llSetText(g_LastCommand_s, <1, 0, 0>, 1.0);
    xlProcessCommand(TRUE);
    llSleep(0.0125);
  }

  for(; id > -1; id--) {
    g_LastCommand_s = "show:" + llList2String(selftest, id);
    llSetText(g_LastCommand_s, <1, 0, 0>, 1.0);
    xlProcessCommand(TRUE);
    llSleep(0.0125);
  }

#endif
  integer AnimsCount = llGetInventoryNumber(INVENTORY_ANIMATION);
  integer index = 0;
  string name;

  for(; index < AnimsCount; index++) {
    name = llGetInventoryName(INVENTORY_ANIMATION, index);

    if(g_AnimUndeform == "") {
      if(llSubStringIndex(name, "undeform") > -1) {
        g_AnimUndeform = name;
      }
    }

    if(g_AnimDeform == "") {
      if(llSubStringIndex(name, "deform") > -1
          && llSubStringIndex(name, "undeform") == -1) {
        g_AnimDeform = name;
      }
    }
  }

  list data = llParseString2List(llGetObjectDesc(), ["*"], []);
  human_mode = llList2Integer(data, 1);
  string color_desc = llList2String(data, 2);

  if(llSubStringIndex(color_desc, "<") != -1) {
    g_Config_BladeColor = (vector)color_desc;
  }

  if(llListFindList(g_LinkDB_l, [MESH_LEG_LEFT_ANIMAL]) == -1
      && llListFindList(g_LinkDB_l, [MESH_LEG_RIGHT_ANIMAL]) == -1) {
    // Animal legs are missing
    g_LastCommand_s = "Hlegs";
    xlProcessCommandWrapper();
    //llOwnerSay("Adjusted for missing animal legs");

  } else if(llListFindList(g_LinkDB_l, [MESH_LEG_LEFT_HUMAN]) == -1
            && llListFindList(g_LinkDB_l, [MESH_LEG_RIGHT_HUMAN]) == -1) {
    // Human Legs are missing
    g_LastCommand_s = "Flegs";
    xlProcessCommandWrapper();
    //llOwnerSay("Adjusted for missing human legs");
  }
}
default {
  changed(integer change)
  {
    if(change & CHANGED_OWNER) {
      llResetScript();

    } else if(change & CHANGED_LINK) {
      //llOwnerSay("Linkset changed, resetting...");
      detectLinkSetMods();
    }
  }
  state_entry()
  {
#ifdef PROFILE_BODY_SCRIPT
    llScriptProfiler(PROFILE_SCRIPT_MEMORY);
#endif
    s_KFTPelvisMeshes_size = s_KFTPelvisMeshes_size;
    bwClear(g_RuntimeBodyStateSettings, FKT_PRESENT);
    bwSet(g_RuntimeBodyStateSettings, FKT_PRESENT);
    bwClear(g_RuntimeBodyStateSettings, FKT_PRESENT);

    /* Set body to alpha masking */
    // TODO: Add configurable alpha mask
    if(g_Config_EnsureMaskingMode) {
      integer aaa = 0;

      for(; aaa <= llGetNumberOfPrims(); aaa++) {
        llSetLinkPrimitiveParamsFast(aaa, [PRIM_ALPHA_MODE, ALL_SIDES,
                                                            PRIM_ALPHA_MODE_MASK, 3]);
      }
    }

    string self = llGetScriptName();
    string basename = "Enhanced Kemono Body";
    string tail = "MISSING_VERSION";

    if(llSubStringIndex(self, " ") >= 0) {
      integer start = 2;
      tail = llGetSubString(self, llStringLength(self) - start, -1);

      while(llGetSubString(tail, 0, 0) != " ") {
        start++;
        tail = llGetSubString(self, llStringLength(self) - start, -1);
      }

      if((integer)tail > 0) {
        basename = llGetSubString(self, 0, -llStringLength(tail) - 1);
      }
    }

    integer n = llGetInventoryNumber(INVENTORY_SCRIPT);

    while(n-- > 0) {
      string item = llGetInventoryName(INVENTORY_SCRIPT, n);

      if(item != self) {
        if(-1 != llSubStringIndex(item, "[Kemono 1.")
            || -1 != llSubStringIndex(item, "[AdvKem")) {
          //llOwnerSay("Removing " + item);
          llRemoveInventory(item);

        } else if(-1 != llSubStringIndex(item, basename)) {
          //llOwnerSay("Upgraded to " + self);
          llRemoveInventory(item);
        }
      }
    }

    if(llGetSubString(llGetObjectName(), 0,
                      llStringLength(UPDATER_NAME) - 1) == UPDATER_NAME) {
      saveSettings();
      llSetObjectName(UPDATER_NAME + " v" + g_internal_version_s);
      //llOwnerSay("Ready for updater");
      llSleep(999);
      llResetScript();
    }

    g_Owner_k = llGetOwner();
    detectLinkSetMods();

    if(llGetAttached()) {
      llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_COLOR, ALL_SIDES,
                                               g_Config_BladeColor, 0.0]);
      llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

    } else {
      llSetLinkPrimitiveParamsFast(LINK_ROOT, [PRIM_COLOR, ALL_SIDES,
                                               g_Config_BladeColor, 1.0]);
    }

    // #ifdef DEBUG_SELF_TEST
    g_LastCommand_s = "show:neck:collar:shoulderUL:shoulderUR:shoulderLL:"
                      + "shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:hipR:thighUL:"
                      + "thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:shinUL:shinUR:"
                      + "shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:armUR:elbowL:"
                      + "elbowR:armLL:armLR:wristL:wristR:handL:handR";
    xlProcessCommand(TRUE);
    llRegionSayTo(g_Owner_k, KEMONO_COM_CH,
                  "show:neck:collar:shoulderUL:shoulderUR:"
                  + "shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
                  + "hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
                  + "shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
                  + "armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
    // #endif
    llSetText("", ZERO_VECTOR, 0.0);
    llListen(KEMONO_COM_CH, "", "", "");
    llWhisper(KEMONO_COM_CH, "reqCLdat");
#ifdef XL_EKB_APPLIER_INCLUDED
    state_entry_applier_hook();
#endif
#ifdef PROFILE_BODY_SCRIPT
    llSetText("U: " + (string)llGetUsedMemory() + "[" + (string)llGetSPMaxMemory() +
              "]/" + (string)llGetMemoryLimit() + "B", HOVER_TEXT_COLOR, HOVER_TEXT_ALPHA);
#endif
  }
  listen(integer channel, string name, key id, string message)
  {
#ifdef XL_EKB_APPLIER_INCLUDED
    textureListener()
#endif
#ifdef BENCHMARK
    llResetTime();
#endif
    key object_owner_k = llGetOwnerKey(id);

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
    if(object_owner_k != g_Owner_k) {
      // Most likely case, make handling other resident's attachments
      // as impactless as we can.
      if(object_owner_k != id) {
        // someboey else's stuff
        return;
      }

      if(llListFindList(g_AttmntAuthedKeys_l, [id]) == -1) {
        return;
      }

      /* probably a detaching object */

    } else { /* if(object_owner_k == g_Owner_k) */
      integer separatorIndex = llSubStringIndex(g_LastCommand_s, ":");

      if(separatorIndex < 0) {
        separatorIndex = 0;
      }

      string first_command = llGetSubString(g_LastCommand_s, 0, separatorIndex - 1);

      // TODO: Allow chaining (read kemono manual for allowed cases?)
      if(first_command == "add") {
        /* And add if not in the auth list */
        if(llGetFreeMemory() > 2048) {
          if(id != g_Owner_k) {
            if(llListFindList(g_AttmntAuthedKeys_l, [id]) == -1) {
              g_AttmntAuthedKeys_l += [id];
              // return;
            }
          }
        }
      }
    }

    g_LastCommand_s = message;
    g_Last_k = id;
    xlProcessCommandWrapper();
#ifdef BENCHMARK
    llOwnerSay("Took " + (string)llGetTime() + " (endof listen)");
#endif
    g_Last_k = NULL_KEY;

    if(llGetAttached()) {
      if(!g_HasAnimPerms) {
        llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

      } else {
        // xlStartAnimation(g_AnimDeform);
        llStopAnimation(g_AnimUndeform);
        llStopAnimation(g_AnimUndeform);
      }
    }
  }
  on_rez(integer p)
  {
    /*Wait a few seconds in case we're still rezzing*/
    saveSettings();
  }
  attach(key id)
  {
    if(llGetSubString(llGetObjectName(), 0,
                      llStringLength(UPDATER_NAME) - 1) == UPDATER_NAME) {
      //llOwnerSay("Updater mode detected.");
      return;
    }

    /* Deform on detach, unlike the stock body. This assumes permissions
    are granted, which happens on rez or startup if attached.
    Needs to be processed as fast as possible to make it before the
    object is pruned from the Current Outfit Folder otherwise
    it won't fire.
    */
    if(id == NULL_KEY) {
      // Don't bother asking for permissions if they were not given
      // The animations are 98% sure to not be applied in that case.
      if(g_HasAnimPerms) {
        xlStartAnimation(g_AnimUndeform);
        xlStartAnimation("stand_1");
        llStopAnimation(g_AnimDeform);
        llStopAnimation(g_AnimUndeform);
      }

    } else {
      llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);

      // Permissions auto-accepted, this will work immediately
      if(g_HasAnimPerms) {
        xlStartAnimation(g_AnimDeform);
        llStopAnimation(g_AnimUndeform);
        llStopAnimation(g_AnimUndeform);
      }

      reset();
      llRegionSayTo(g_Owner_k, KEMONO_COM_CH, KM_HUD_RESET_CMD);
    }
  }
  run_time_permissions(integer perm)
  {
    // What?
    //if(!g_HasAnimPerms){
    //  resetHands();
    //}
    if(perm & PERMISSION_TRIGGER_ANIMATION) {
      g_HasAnimPerms = TRUE;
    }

#ifdef RESET_ON_PERMS
    /* Send a "reset" message to forcefully trigger clothing autohiders */
    llRegionSayTo(g_Owner_k, KEMONO_COM_CH,
                  "show:neck:collar:shoulderUL:shoulderUR:"
                  + "shoulderLL:shoulderLR:chest:breast:ribs:abs:belly:pelvis:hipL:"
                  + "hipR:thighUL:thighUR:thighLL:thighLR:kneeL:kneeR:calfL:calfR:"
                  + "shinUL:shinUR:shinLL:shinLR:ankleL:ankleR:footL:footR:armUL:"
                  + "armUR:elbowL:elbowR:armLL:armLR:wristL:wristR:handL:handR");
#endif
    llSetTimerEvent(1);
  }
  timer()
  // #undef SMART_DEFORM
  {
    if(llGetAttached()) {
      integer new_anim_count = llGetListLength(llGetAnimationList(g_Owner_k));

      if(anim_count != new_anim_count) {
        anim_count = new_anim_count;

        if(g_HasAnimPerms) {
#ifdef SMART_DEFORM

          if(llGetAgentInfo(g_Owner_k)&AGENT_SITTING) {
            xlStartAnimation(g_AnimUndeform);
            llStopAnimation(g_AnimDeform);

          } else {
#endif
            xlStartAnimation(g_AnimDeform);
            //llStopAnimation(g_AnimUndeform);
#ifdef SMART_DEFORM
          }

#endif

        } else {
          // llOwnerSay("Requesting permissions");
          llRequestPermissions(g_Owner_k, PERMISSION_TRIGGER_ANIMATION);
        }
      }
    }
  }
  link_message(integer sender_num, integer num, string message, key id)
  {
    llOwnerSay("LINK MESSAGE[" + (string)id + "]: '" + message + "'");
  }
}
