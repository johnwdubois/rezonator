{
    "id": "d150cb69-ac41-4fe0-9d65-b40ecc47470f",
    "modelName": "GMExtension",
    "mvc": "1.2",
    "name": "FileManager",
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
    "copyToTargets": 202375362,
    "date": "2019-07-11 11:06:29",
    "description": "",
    "exportToGame": true,
    "extensionName": "",
    "files": [
        {
            "id": "5c10ad61-4785-4a76-8d2c-94cb68502f56",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 1048640,
            "filename": "FileManager.dll",
            "final": "",
            "functions": [
                {
                    "id": "22af407f-86df-4db0-bf2b-daa205fa6e80",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_copy",
                    "help": "file_copy(fname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_copy",
                    "returnType": 2
                },
                {
                    "id": "21ceec61-7eab-44df-bcf8-cd35dfcb6292",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_rename",
                    "help": "file_rename(oldname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_rename",
                    "returnType": 2
                },
                {
                    "id": "a02e4b1b-06b5-4df1-a4fb-5c54ed4ff532",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_exists",
                    "help": "file_exists(fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_exists",
                    "returnType": 2
                },
                {
                    "id": "0b70cf06-e1c0-43f9-855a-d7da4f4f46bf",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_delete",
                    "help": "file_delete(fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_delete",
                    "returnType": 2
                },
                {
                    "id": "dfd8b8a6-5b2d-4139-b210-a66a25a5b907",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_create",
                    "help": "directory_create(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_create",
                    "returnType": 2
                },
                {
                    "id": "133bb5e6-c493-45c5-947e-b351a319507b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_copy",
                    "help": "directory_copy(dname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_copy",
                    "returnType": 2
                },
                {
                    "id": "4b313632-56f5-45b7-868f-000081d3a6e5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_rename",
                    "help": "directory_rename(oldname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_rename",
                    "returnType": 2
                },
                {
                    "id": "cd22b674-ba09-4bf0-91c2-8aa77bc4cb6e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_exists",
                    "help": "directory_exists(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_exists",
                    "returnType": 2
                },
                {
                    "id": "b0675184-bd82-42ba-a760-83a061446159",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_destroy",
                    "help": "directory_destroy(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_destroy",
                    "returnType": 2
                },
                {
                    "id": "d63b9c92-9bd8-4ba3-a4d6-ad97dcefad35",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "environment_get_variable",
                    "help": "environment_get_variable(name)",
                    "hidden": false,
                    "kind": 12,
                    "name": "environment_get_variable",
                    "returnType": 1
                },
                {
                    "id": "f409adb2-e82f-401b-b494-28e1cdd7bb9b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "set_working_directory",
                    "help": "set_working_directory(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "set_working_directory",
                    "returnType": 2
                },
                {
                    "id": "5e3c8fce-4614-4a9a-b75f-da22d55d9169",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "get_working_directory",
                    "help": "get_working_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_working_directory",
                    "returnType": 1
                },
                {
                    "id": "5bccc9a1-c655-4e95-ac6b-63cc2d0b2051",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_program_directory",
                    "help": "get_program_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_program_directory",
                    "returnType": 1
                },
                {
                    "id": "2da52ab7-0428-4021-83a9-81e5534c87db",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_temp_directory",
                    "help": "get_temp_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_temp_directory",
                    "returnType": 1
                },
                {
                    "id": "6f346607-0fcd-4c2f-8ea4-bd15c14cbb3b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "environment_set_variable",
                    "help": "environment_set_variable(name,value)",
                    "hidden": false,
                    "kind": 12,
                    "name": "environment_set_variable",
                    "returnType": 2
                },
                {
                    "id": "6941f746-3c14-4b75-a297-dd971aefac62",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_contents",
                    "help": "directory_contents(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_contents",
                    "returnType": 1
                }
            ],
            "init": "get_working_directory",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\FileManager.dll",
            "uncompress": false
        },
        {
            "id": "ed57f939-6d3d-43a8-b892-66483e12cede",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "FileManager.dll.zip",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\FileManager.dll.zip",
            "uncompress": false
        },
        {
            "id": "5d41a60e-50d2-4157-926a-701975b62b90",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 67108866,
            "filename": "FileManager.dylib",
            "final": "",
            "functions": [
                {
                    "id": "dca95663-5b2a-41a8-8ccc-0aa854d0ab3c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_copy",
                    "help": "file_copy(fname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_copy",
                    "returnType": 2
                },
                {
                    "id": "b06379af-d5f9-4110-84a5-a408b587aa56",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_rename",
                    "help": "file_rename(oldname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_rename",
                    "returnType": 2
                },
                {
                    "id": "5cacb0f8-14f5-4d06-a6c3-0ef3c903bcd0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_exists",
                    "help": "file_exists(fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_exists",
                    "returnType": 2
                },
                {
                    "id": "1dd04cb5-6e66-4d58-b5bd-460fa6a6e880",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_delete",
                    "help": "file_delete(fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_delete",
                    "returnType": 2
                },
                {
                    "id": "3601f36c-7c05-457e-a525-ae098dfa30b9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_create",
                    "help": "directory_create(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_create",
                    "returnType": 2
                },
                {
                    "id": "374fcdaa-7f6d-4eef-8850-1c258ad24256",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_copy",
                    "help": "directory_copy(dname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_copy",
                    "returnType": 2
                },
                {
                    "id": "5a4446b3-b056-4d17-80ef-7ac771b9423d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_rename",
                    "help": "directory_rename(oldname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_rename",
                    "returnType": 2
                },
                {
                    "id": "b4a9110a-29f0-42da-b28a-11dad2416ca2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_exists",
                    "help": "directory_exists(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_exists",
                    "returnType": 2
                },
                {
                    "id": "57ae5430-3fb8-4e6f-9c34-0c9d45a7f5da",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_destroy",
                    "help": "directory_destroy(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_destroy",
                    "returnType": 2
                },
                {
                    "id": "6260bc7f-92c5-4792-a99c-3a2582b2b5d6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "environment_get_variable",
                    "help": "environment_get_variable(name)",
                    "hidden": false,
                    "kind": 12,
                    "name": "environment_get_variable",
                    "returnType": 1
                },
                {
                    "id": "566d8fa2-218a-4d68-a0f1-7ee0cfba8893",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "set_working_directory",
                    "help": "set_working_directory(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "set_working_directory",
                    "returnType": 2
                },
                {
                    "id": "88c42c47-12a1-44a0-a699-3b124819832b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "get_working_directory",
                    "help": "get_working_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_working_directory",
                    "returnType": 1
                },
                {
                    "id": "bfffabc3-4130-42d0-933b-f49a0760d54d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_program_directory",
                    "help": "get_program_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_program_directory",
                    "returnType": 1
                },
                {
                    "id": "394e7825-01f4-4385-a92b-bf1eb2e05ebc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_temp_directory",
                    "help": "get_temp_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_temp_directory",
                    "returnType": 1
                },
                {
                    "id": "a25a9b95-355b-4c1a-82a9-bb46237718de",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "environment_set_variable",
                    "help": "environment_set_variable(name,value)",
                    "hidden": false,
                    "kind": 12,
                    "name": "environment_set_variable",
                    "returnType": 2
                },
                {
                    "id": "035d5a40-b24f-47fa-beb4-4bac444fe31f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_contents",
                    "help": "directory_contents(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_contents",
                    "returnType": 1
                }
            ],
            "init": "get_working_directory",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\FileManager.dylib",
            "uncompress": false
        },
        {
            "id": "8f7908b8-5352-4d00-8e5e-8029c4830922",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "FileManager.dylib.zip",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\FileManager.dylib.zip",
            "uncompress": false
        },
        {
            "id": "4cee6db1-bf63-49cc-8018-12b50604c076",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 134217856,
            "filename": "FileManager.so",
            "final": "",
            "functions": [
                {
                    "id": "b58de356-faad-4739-a259-8d4e2ea33485",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_copy",
                    "help": "file_copy(fname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_copy",
                    "returnType": 2
                },
                {
                    "id": "6da51525-af6b-48db-b16a-38c5452e69a7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_rename",
                    "help": "file_rename(oldname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_rename",
                    "returnType": 2
                },
                {
                    "id": "7e2292d1-1530-45d9-b16a-8067b644cbef",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_exists",
                    "help": "file_exists(fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_exists",
                    "returnType": 2
                },
                {
                    "id": "4bc9a755-3875-4c54-8615-ef26ba84d489",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_delete",
                    "help": "file_delete(fname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "file_delete",
                    "returnType": 2
                },
                {
                    "id": "6c15b497-9e41-419f-873a-d1b55e494088",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_create",
                    "help": "directory_create(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_create",
                    "returnType": 2
                },
                {
                    "id": "8f6c7633-9a52-48ed-a0cc-2abb23ebf83b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_copy",
                    "help": "directory_copy(dname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_copy",
                    "returnType": 2
                },
                {
                    "id": "693901a8-f9c3-457a-b700-0c78029b93bf",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_rename",
                    "help": "directory_rename(oldname,newname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_rename",
                    "returnType": 2
                },
                {
                    "id": "7cd4504f-5ae4-4718-8017-5f1df1ba972c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_exists",
                    "help": "directory_exists(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_exists",
                    "returnType": 2
                },
                {
                    "id": "cff5c0d4-fa38-4f5e-bba0-1ee055f1360a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_destroy",
                    "help": "directory_destroy(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_destroy",
                    "returnType": 2
                },
                {
                    "id": "e52111e3-3833-43ed-bafb-31d4e80b11ae",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "environment_get_variable",
                    "help": "environment_get_variable(name)",
                    "hidden": false,
                    "kind": 12,
                    "name": "environment_get_variable",
                    "returnType": 1
                },
                {
                    "id": "3e7aa4c0-a6f8-4c21-8943-ff739eb485b3",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "set_working_directory",
                    "help": "set_working_directory(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "set_working_directory",
                    "returnType": 2
                },
                {
                    "id": "d7345579-52e0-44a3-af16-7964ce0b67eb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_working_directory",
                    "help": "get_working_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_working_directory",
                    "returnType": 1
                },
                {
                    "id": "c8e605a0-02ef-4055-a6dc-40ac893dd54c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_program_directory",
                    "help": "get_program_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_program_directory",
                    "returnType": 1
                },
                {
                    "id": "6f3ebc8b-3426-41d4-8590-fbe3219f33cc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "get_temp_directory",
                    "help": "get_temp_directory()",
                    "hidden": false,
                    "kind": 12,
                    "name": "get_temp_directory",
                    "returnType": 1
                },
                {
                    "id": "7e969440-bf6b-4567-b49c-440f38ccc245",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "environment_set_variable",
                    "help": "environment_set_variable(name,value)",
                    "hidden": false,
                    "kind": 12,
                    "name": "environment_set_variable",
                    "returnType": 2
                },
                {
                    "id": "e21c9070-39c6-40b0-8671-a98345b04446",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_contents",
                    "help": "directory_contents(dname)",
                    "hidden": false,
                    "kind": 12,
                    "name": "directory_contents",
                    "returnType": 1
                }
            ],
            "init": "get_working_directory",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\FileManager.so",
            "uncompress": false
        },
        {
            "id": "169d198c-3f44-4806-97e8-41cc7e478311",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 0,
            "filename": "FileManager.so.zip",
            "final": "",
            "functions": [
                
            ],
            "init": "",
            "kind": 4,
            "order": [
                
            ],
            "origname": "extensions\\FileManager.so.zip",
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
    "license": "Free to use, also for commercial games.",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "options": null,
    "optionsFile": "options.json",
    "packageID": "",
    "productID": "ACBD3CFF4E539AD869A0E8E3B4B022DD",
    "sourcedir": "",
    "supportedTargets": 202375362,
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
    "version": "1.0.0"
}