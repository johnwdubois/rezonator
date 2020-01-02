{
    "id": "6b96859d-3823-476b-8983-1f6d20c1dd2d",
    "modelName": "GMExtension",
    "mvc": "1.2",
    "name": "audioviz2",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": false,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 64,
    "date": "2019-05-20 08:04:14",
    "description": "",
    "exportToGame": true,
    "extensionName": "",
    "files": [
        {
            "id": "56019e15-ecc5-43e8-ba03-d55700dc35ad",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "651a6c58-7a7a-4e8a-8be6-0db19e9c3cf8",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "AVIZ_DEBUGMODE_NONE",
                    "hidden": false,
                    "value": "0"
                },
                {
                    "id": "8637bdcc-61ca-43fc-8127-236934304d68",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "AVIZ_DEBUGMODEG_ERROR",
                    "hidden": false,
                    "value": "1"
                },
                {
                    "id": "f229c2cd-430d-4d3f-9927-0fc99fd1cb5d",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "AVIZ_DEBUGMODE_WARNING",
                    "hidden": false,
                    "value": "2"
                },
                {
                    "id": "041d9033-0256-4180-bed6-5b4d40116317",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "AVIZ_DEBUGMODE_INFO",
                    "hidden": false,
                    "value": "3"
                },
                {
                    "id": "a70daa68-eedd-4b43-ac3f-7e86200b7a48",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "AVIZ_DEBUGMODE_DEBUG",
                    "hidden": false,
                    "value": "4"
                }
            ],
            "copyToTargets": 64,
            "filename": "gm_audioviz2.dll",
            "final": "",
            "functions": [
                {
                    "id": "5a0b62c1-ec42-4070-885e-272f0d6eb56f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        1
                    ],
                    "externalName": "audioviz_create",
                    "help": "aviz_create(path)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_create",
                    "returnType": 2
                },
                {
                    "id": "c38f473b-033b-447d-8955-4376f46171b7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_destroy",
                    "help": "aviz_destroy(id)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_destroy",
                    "returnType": 2
                },
                {
                    "id": "b6a9f3d0-0e90-4bbd-916c-f476a8fdbcec",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_exists",
                    "help": "aviz_exists(id)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_exists",
                    "returnType": 2
                },
                {
                    "id": "4e8a65f3-eafe-421a-95e7-bc102420cdd9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_get_duration",
                    "help": "aviz_get_duration(id)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_get_duration",
                    "returnType": 2
                },
                {
                    "id": "8bd60cff-7a0d-4c7f-b69f-7342cec346cf",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_get_samples",
                    "help": "aviz_get_samples(id)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_get_samples",
                    "returnType": 2
                },
                {
                    "id": "23b05162-0736-43ef-a5b2-bae06d2b1f5c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_get_samplerate",
                    "help": "aviz_get_samplerate(id)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_get_samplerate",
                    "returnType": 2
                },
                {
                    "id": "a80e7e69-e262-4858-8887-70249089d16f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_get_channels",
                    "help": "aviz_get_channels(id)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_get_channels",
                    "returnType": 2
                },
                {
                    "id": "1b75012e-2a0f-46e0-bdbe-b86fbfa58084",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        1,
                        1,
                        2
                    ],
                    "externalName": "audioviz_tick",
                    "help": "aviz_tick(id, audio_buffer, spectrum_buffer, samples)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_tick",
                    "returnType": 2
                },
                {
                    "id": "8f8cbf65-00f3-4234-b2ae-b48dcaeb345a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "audioviz_seek",
                    "help": "aviz_seek(id, sample)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_seek",
                    "returnType": 2
                },
                {
                    "id": "57d2956e-c0dd-4331-9b51-2d7909b62ed8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2
                    ],
                    "externalName": "audioviz_set_debug_mode",
                    "help": "aviz_set_debug_mode(mode)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_set_debug_mode",
                    "returnType": 2
                },
                {
                    "id": "c00ed96c-8102-44a5-971e-f0e3cb6f98b4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        2,
                        1,
                        2
                    ],
                    "externalName": "audioviz_render",
                    "help": "aviz_render(id, buffer, render_width)",
                    "hidden": false,
                    "kind": 1,
                    "name": "aviz_render",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                "5a0b62c1-ec42-4070-885e-272f0d6eb56f",
                "c38f473b-033b-447d-8955-4376f46171b7",
                "b6a9f3d0-0e90-4bbd-916c-f476a8fdbcec",
                "4e8a65f3-eafe-421a-95e7-bc102420cdd9",
                "8bd60cff-7a0d-4c7f-b69f-7342cec346cf",
                "23b05162-0736-43ef-a5b2-bae06d2b1f5c",
                "a80e7e69-e262-4858-8887-70249089d16f",
                "1b75012e-2a0f-46e0-bdbe-b86fbfa58084",
                "8f8cbf65-00f3-4234-b2ae-b48dcaeb345a",
                "c00ed96c-8102-44a5-971e-f0e3cb6f98b4",
                "57d2956e-c0dd-4331-9b51-2d7909b62ed8"
            ],
            "origname": "",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": false,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "options": null,
    "optionsFile": "options.json",
    "packageID": "",
    "productID": "",
    "sourcedir": "",
    "supportedTargets": 64,
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "2.0.0"
}