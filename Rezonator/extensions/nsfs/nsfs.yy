{
    "id": "0d280dcd-4202-4253-bc2c-2ea02bac4020",
    "modelName": "GMExtension",
    "mvc": "1.0",
    "name": "nsfs",
    "IncludedResources": [
        "Sprites\\spr_nsfs_demo_white32",
        "Scripts\\demo-scripts\\demo_button",
        "Scripts\\demo-scripts\\demo_trace",
        "Scripts\\demo-scripts\\demo_prompt",
        "Scripts\\demo-scripts\\demo_param",
        "Scripts\\demo-scripts\\demo_sfmt",
        "Scripts\\demo-scripts\\demo_status",
        "Fonts\\fnt_nsfs_demo",
        "Objects\\obj_nsfs_demo",
        "Rooms\\rm_nsfs_demo",
        "Included Files\\nsfs-doc.html"
    ],
    "androidPermissions": [
        
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 105554163798254,
    "date": "2019-32-01 08:01:57",
    "description": "",
    "extensionName": "",
    "files": [
        {
            "id": "dd4c2d44-6139-4d26-9295-b66ddefd4e34",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 113497714299118,
            "filename": "nsfs.dll",
            "final": "",
            "functions": [
                {
                    "id": "2086670b-2cd3-495a-9446-d7cb36d3414c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "nsfs_get_status",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "nsfs_get_status",
                    "returnType": 2
                },
                {
                    "id": "abf7ba4c-1f13-4639-aebe-2b12132bfb10",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "nsfs_get_directory",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "nsfs_get_directory",
                    "returnType": 1
                },
                {
                    "id": "ff2ccf34-e31c-4360-b6b8-799ffed4eecc",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "nsfs_set_directory",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "nsfs_set_directory",
                    "returnType": 2
                },
                {
                    "id": "459325d8-f819-47ea-880a-40d1c03dc2a0",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "nsfs_init_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "nsfs_init_raw",
                    "returnType": 2
                },
                {
                    "id": "9b92620a-7d41-4e67-a055-58a832a474e5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_get_attributes_ns",
                    "help": "file_get_attributes_ns(path) : returned values as per https:\/\/msdn.microsoft.com\/en-us\/library\/windows\/desktop\/gg258117(v=vs.85).aspx",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_get_attributes_ns",
                    "returnType": 2
                },
                {
                    "id": "ac830642-ffe0-41ca-8d29-2b4afd0921d5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "file_set_attributes_ns",
                    "help": "file_set_attributes_ns(path, flags) : flags as per https:\/\/msdn.microsoft.com\/en-us\/library\/windows\/desktop\/gg258117(v=vs.85).aspx",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_set_attributes_ns",
                    "returnType": 2
                },
                {
                    "id": "4de200fd-595b-4308-a492-40bf6099dd14",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_get_size_ns",
                    "help": "file_get_size_ns(path) : Returns size of the given file, in bytes.",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_get_size_ns",
                    "returnType": 2
                },
                {
                    "id": "09de4582-8a64-4114-aaa3-417c4b51e60e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_exists_ns",
                    "help": "file_exists_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_exists_ns",
                    "returnType": 2
                },
                {
                    "id": "4047065e-fea0-41eb-8669-fcce8826eb29",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_exists_ns",
                    "help": "directory_exists_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "directory_exists_ns",
                    "returnType": 2
                },
                {
                    "id": "78960976-fa8b-48dc-ad5d-d54b7a07b6ee",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_delete_ns",
                    "help": "file_delete_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_delete_ns",
                    "returnType": 2
                },
                {
                    "id": "13f4f69f-9173-46e9-bf37-aae2ed64a2ba",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_create_ns",
                    "help": "directory_create_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "directory_create_ns",
                    "returnType": 2
                },
                {
                    "id": "923a69cb-cbda-4cca-aca9-11d4e5c75503",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "directory_delete_ns",
                    "help": "directory_delete_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "directory_delete_ns",
                    "returnType": 2
                },
                {
                    "id": "79e1f42b-efec-4f89-b3d5-887ae3f6ddb8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_copy_ns",
                    "help": "file_copy_ns(from, to)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_copy_ns",
                    "returnType": 2
                },
                {
                    "id": "c2c8ffc2-6eb3-478d-a709-29aa243c7fe4",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_copy_ns",
                    "help": "directory_copy_ns(from, to)",
                    "hidden": false,
                    "kind": 11,
                    "name": "directory_copy_ns",
                    "returnType": 2
                },
                {
                    "id": "f68d75c2-821c-4c2f-8caf-b3f6216a117e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_rename_ns",
                    "help": "file_rename_ns(from, to)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_rename_ns",
                    "returnType": 2
                },
                {
                    "id": "62a256ec-5876-4b2d-b1cc-55f4b90d3687",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_rename_ns",
                    "help": "directory_rename_ns(from, to)",
                    "hidden": false,
                    "kind": 11,
                    "name": "directory_rename_ns",
                    "returnType": 2
                },
                {
                    "id": "4b0ec0f8-526b-4304-b008-97947f5438d8",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "file_move_ns",
                    "help": "file_move_ns(from, to)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_move_ns",
                    "returnType": 2
                },
                {
                    "id": "46dad09e-2749-4023-aa1f-5947b9a91b62",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "directory_move_ns",
                    "help": "directory_move_ns(from, to)",
                    "hidden": false,
                    "kind": 11,
                    "name": "directory_move_ns",
                    "returnType": 2
                },
                {
                    "id": "d95ab932-1e38-40ce-b298-c2d4a93a2ff1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "file_find_first_ns",
                    "help": "file_find_first_ns(mask)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_find_first_ns",
                    "returnType": 1
                },
                {
                    "id": "4cef17a9-ecae-459f-b8ab-df4a10b0b63f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_next_ns",
                    "help": "file_find_next_ns()",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_find_next_ns",
                    "returnType": 1
                },
                {
                    "id": "fb763bf9-6d7d-4406-9ca8-f919511e5be6",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_close_ns",
                    "help": "file_find_close_ns()",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_find_close_ns",
                    "returnType": 2
                },
                {
                    "id": "847c7633-db47-42ce-940f-9407e69aa0fa",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_attributes_ns",
                    "help": "file_find_attributes_ns() : Returns the attributes of the current file in file_find",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_find_attributes_ns",
                    "returnType": 2
                },
                {
                    "id": "97376928-de6c-4943-8987-824fa2214137",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "file_find_size_ns",
                    "help": "file_find_size_ns() : Returns the size (in bytes) of the current file in file_find",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_find_size_ns",
                    "returnType": 2
                },
                {
                    "id": "c703e10e-805d-43d3-bbe2-c76b0e31628b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "file_text_open_read_ns",
                    "help": "file_text_open_read_ns(path, codepage) : Codepage can be set to -1 for default (UTF-8)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_open_read_ns",
                    "returnType": 2
                },
                {
                    "id": "57b73bd2-8790-4309-a242-c41f47b33b4a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "file_text_open_write_ns",
                    "help": "file_text_open_write_ns(path, codepage) : Codepage can be set to -1 for default (UTF-8)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_open_write_ns",
                    "returnType": 2
                },
                {
                    "id": "889e3da3-3ed6-447e-9786-712a1f8a9178",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "file_text_open_append_ns",
                    "help": "file_text_open_append_ns(path, codepage) : Codepage can be set to -1 for default (UTF-8)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_open_append_ns",
                    "returnType": 2
                },
                {
                    "id": "49ee29b2-8939-4c9a-97ef-75e5f1899ae2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "file_text_close_ns",
                    "help": "file_text_close_ns(fileid)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_close_ns",
                    "returnType": 2
                },
                {
                    "id": "cd189faf-3233-4335-9b1e-4e5f551c59f7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "file_text_eof_ns",
                    "help": "file_text_eof_ns(fileid)",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_eof_ns",
                    "returnType": 2
                },
                {
                    "id": "41b3665a-b20d-45d3-9396-57c134fb28c1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "file_text_read_line_ns",
                    "help": "file_text_read_line_ns(fileid) : Reads the next line from a file, skips line separators after it.",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_read_line_ns",
                    "returnType": 1
                },
                {
                    "id": "305e6f25-5457-423c-9898-c9238e7db035",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        1
                    ],
                    "externalName": "file_text_write_line_ns",
                    "help": "file_text_write_line_ns(fileid, text) : Writes a line and line separators into a file.",
                    "hidden": false,
                    "kind": 11,
                    "name": "file_text_write_line_ns",
                    "returnType": 2
                },
                {
                    "id": "c60876aa-9444-46a5-b169-04e0c6305c7e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "buffer_load_ns_raw1",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "buffer_load_ns_raw1",
                    "returnType": 2
                },
                {
                    "id": "20a7e2eb-b794-42c3-bfe0-33f3861f0acf",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "buffer_load_ns_raw2",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "buffer_load_ns_raw2",
                    "returnType": 2
                },
                {
                    "id": "ffed5f6e-2ee9-4142-b749-095399568e04",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        1,
                        1,
                        2,
                        2
                    ],
                    "externalName": "buffer_save_ns_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "buffer_save_ns_raw",
                    "returnType": 2
                },
                {
                    "id": "87159b9f-b66e-430f-8da9-10b6c268fdd1",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "string_load_ns",
                    "help": "string_load_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "string_load_ns",
                    "returnType": 1
                },
                {
                    "id": "0e1e7895-24ab-438c-b441-5ee38ce18424",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        1
                    ],
                    "externalName": "string_save_ns",
                    "help": "string_save_ns(str, path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "string_save_ns",
                    "returnType": 2
                },
                {
                    "id": "a7853ec4-7015-4e79-9ebc-4e2558ec0d13",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        2,
                        2
                    ],
                    "externalName": "string_codepage",
                    "help": "string_codepage(str, codepage_from, codepage_to) : Converts a string between codepages. From\/to can be set to -1 for UTF-8",
                    "hidden": false,
                    "kind": 11,
                    "name": "string_codepage",
                    "returnType": 1
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\nsfs.dll",
            "uncompress": false
        },
        {
            "id": "9dde549b-61b0-4e09-af63-de2babe520ab",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "60306a6b-1399-42a7-9102-10ab2d74768a",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "nsfs_status",
                    "hidden": false,
                    "value": "nsfs_get_status()"
                },
                {
                    "id": "565040e8-b874-40a4-9001-575c0e1a8abc",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "nsfs_is_available",
                    "hidden": false,
                    "value": "global.g_nsfs_is_available"
                }
            ],
            "copyToTargets": 113497714299118,
            "filename": "nsfs.gml",
            "final": "",
            "functions": [
                {
                    "id": "3e92bb5f-9453-4979-8d62-7e1ba0910d82",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "nsfs_init",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "nsfs_init",
                    "returnType": 2
                },
                {
                    "id": "08c51043-2e08-4bf0-9916-dbe0cc43976d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "buffer_load_ns",
                    "help": "buffer_load_ns(nspath, kind = buffer_grow)",
                    "hidden": false,
                    "kind": 11,
                    "name": "buffer_load_ns",
                    "returnType": 2
                },
                {
                    "id": "195d867c-b03b-45bc-aeef-d953fe9a176f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "buffer_save_ns",
                    "help": "buffer_save_ns(buffer)",
                    "hidden": false,
                    "kind": 11,
                    "name": "buffer_save_ns",
                    "returnType": 2
                },
                {
                    "id": "6d3379e7-54ef-4e2f-ac53-30003bb16af5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 4,
                    "args": [
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "buffer_save_ext_ns",
                    "help": "buffer_save_ext_ns(buffer, path, offset, size)",
                    "hidden": false,
                    "kind": 11,
                    "name": "buffer_save_ext_ns",
                    "returnType": 2
                },
                {
                    "id": "21fa94b4-2a12-4011-b6c3-40329f3400e9",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "ini_open_ns",
                    "help": "ini_open_ns(path)",
                    "hidden": false,
                    "kind": 11,
                    "name": "ini_open_ns",
                    "returnType": 2
                },
                {
                    "id": "40a4a031-65e9-4ec7-862c-2bae518d3310",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "ini_close_ns",
                    "help": "ini_close_ns()",
                    "hidden": false,
                    "kind": 11,
                    "name": "ini_close_ns",
                    "returnType": 2
                },
                {
                    "id": "ab2a95d9-9096-4cb0-bc8c-51838037231d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 7,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "sprite_replace_ns",
                    "help": "sprite_replace_ns(ind, nspath, imgnumb, removeback, smooth, xorig, yorig)",
                    "hidden": false,
                    "kind": 11,
                    "name": "sprite_replace_ns",
                    "returnType": 2
                },
                {
                    "id": "72b29c05-ba8d-4aa8-9f26-a9e4da574715",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 6,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "sprite_add_ns",
                    "help": "sprite_add_ns(nspath, imgnumb, removeback, smooth, xorig, yorig)",
                    "hidden": false,
                    "kind": 11,
                    "name": "sprite_add_ns",
                    "returnType": 2
                },
                {
                    "id": "8d99d713-c933-4fbe-bb40-cda5d122ee1d",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "surface_save_ns",
                    "help": "surface_save_ns(surface, nspath)",
                    "hidden": false,
                    "kind": 11,
                    "name": "surface_save_ns",
                    "returnType": 2
                },
                {
                    "id": "1d3cc2c6-677c-444c-972a-f504f7f76cee",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 6,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "surface_save_part_ns",
                    "help": "surface_save_part_ns(surface, nspath, rx, ry, rw, rh)",
                    "hidden": false,
                    "kind": 11,
                    "name": "surface_save_part_ns",
                    "returnType": 2
                },
                {
                    "id": "822dbb30-fc6a-43fa-9ab9-33bf3974e65f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "screen_save_ns",
                    "help": "screen_save_ns(nspath)",
                    "hidden": false,
                    "kind": 11,
                    "name": "screen_save_ns",
                    "returnType": 2
                },
                {
                    "id": "4135d67b-cd63-466a-95e5-b05cd5e6568f",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 5,
                    "args": [
                        2,
                        2,
                        2,
                        2,
                        2
                    ],
                    "externalName": "screen_save_part_ns",
                    "help": "screen_save_part_ns(nspath, rx, ry, rw, rh)",
                    "hidden": false,
                    "kind": 11,
                    "name": "screen_save_part_ns",
                    "returnType": 2
                }
            ],
            "init": "nsfs_init",
            "kind": 2,
            "order": [
                
            ],
            "origname": "extensions\\gml.gml",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "Proprietary",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "packageID": "cc.yal.nsfs",
    "productID": "F79C97955FD1AF4686EB4EF4EF90F0DB",
    "sourcedir": "",
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
    "version": "1.0.3"
}