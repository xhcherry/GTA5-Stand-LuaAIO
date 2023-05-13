-- Curated Attachments

local SCRIPT_VERSION = "0.31"

local curated_attachments <const> = {
    {
        name = "Objects",
        is_folder = true,
        items = {
            {
                name = "Lights",
                is_folder = true,
                items = {
                    {
                        name = "Red Spinning Light",
                        model = "hei_prop_wall_light_10a_cr",
                        offset = { x = 0, y = 0, z = 1 },
                        rotation = { x = 180, y = 0, z = 0 },
                        options = {
                            is_light_disabled = true,
                            has_collision = false,
                        },
                        children = {
                            {
                                model = "prop_wall_light_10a",
                                offset = { x = 0, y = 0.01, z = 0 },
                                options = {
                                    is_light_disabled = false,
                                    bone_index = 1,
                                    has_collision = false,
                                },
                            },
                        },
                    },
                    {
                        name = "Blue Spinning Light",
                        model = "hei_prop_wall_light_10a_cr",
                        offset = { x = 0, y = 0, z = 1 },
                        rotation = { x = 180, y = 0, z = 0 },
                        options = {
                            is_light_disabled = true,
                            has_collision = false,
                        },
                        children = {
                            {
                                model = "prop_wall_light_10b",
                                offset = { x = 0, y = 0.01, z = 0 },
                                options = {
                                    is_light_disabled = false,
                                    bone_index = 1,
                                    has_collision = false,
                                },
                            },
                        },
                    },
                    {
                        name = "Yellow Spinning Light",
                        model = "hei_prop_wall_light_10a_cr",
                        offset = { x = 0, y = 0, z = 1 },
                        rotation = { x = 180, y = 0, z = 0 },
                        options = {
                            is_light_disabled = true,
                            has_collision = false,
                        },
                        children = {
                            {
                                model = "prop_wall_light_10c",
                                offset = { x = 0, y = 0.01, z = 0 },
                                options = {
                                    is_light_disabled = false,
                                    bone_index = 1,
                                    has_collision = false,
                                },
                            },
                        },
                    },

                    {
                        name = "Combo Red+Blue Spinning Light",
                        model = "hei_prop_wall_light_10a_cr",
                        offset = { x = 0, y = 0, z = 1 },
                        rotation = { x = 180, y = 0, z = 0 },
                        options = {
                            is_light_disabled = true,
                            has_collision = false,
                        },
                        children = {
                            {
                                model = "prop_wall_light_10b",
                                offset = { x = 0, y = 0.01, z = 0 },
                                options = {
                                    is_light_disabled = false,
                                    bone_index = 1,
                                    has_collision = false,
                                },
                            },
                            {
                                model = "prop_wall_light_10a",
                                offset = { x = 0, y = 0.01, z = 0 },
                                rotation = { x = 0, y = 0, z = 180 },
                                options = {
                                    is_light_disabled = false,
                                    bone_index = 1,
                                    has_collision = false,
                                },
                            },
                        },
                        --reflection = {
                        --    model = "hei_prop_wall_light_10a_cr",
                        --    reflection_axis = { x = true, y = false, z = false },
                        --    options = { is_light_disabled = true },
                        --    children = {
                        --        {
                        --            model = "prop_wall_light_10a",
                        --            offset = { x = 0, y = 0.01, z = 0 },
                        --            rotation = { x = 0, y = 0, z = 180 },
                        --            options = { is_light_disabled = false },
                        --            bone_index = 1,
                        --        },
                        --    },
                        --}
                    },

                    {
                        name = "Pair of Spinning Lights",
                        model = "hei_prop_wall_light_10a_cr",
                        offset = { x = 0.3, y = 0, z = 1 },
                        rotation = { x = 180, y = 0, z = 0 },
                        options = {
                            is_light_disabled = true,
                            has_collision = false,
                        },
                        children = {
                            {
                                model = "prop_wall_light_10b",
                                offset = { x = 0, y = 0.01, z = 0 },
                                options = {
                                    is_light_disabled = false,
                                    bone_index = 1,
                                    has_collision = false,
                                },
                            },
                            {
                                model = "hei_prop_wall_light_10a_cr",
                                reflection_axis = { x = true, y = false, z = false },
                                options = {
                                    is_light_disabled = true,
                                    has_collision = false,
                                },
                                children = {
                                    {
                                        model = "prop_wall_light_10a",
                                        offset = { x = 0, y = 0.01, z = 0 },
                                        rotation = { x = 0, y = 0, z = 180 },
                                        options = {
                                            is_light_disabled = false,
                                            bone_index = 1,
                                            has_collision = false,
                                        },
                                    },
                                },
                            }
                        },
                    },

                    {
                        name = "Short Spinning Red Light",
                        model = "hei_prop_wall_alarm_on",
                        offset = { x = 0, y = 0, z = 1 },
                        rotation = { x = -90, y = 0, z = 0 },
                    },
                    {
                        name = "Small Red Warning Light",
                        model = "prop_warninglight_01",
                        offset = { x = 0, y = 0, z = 1 },
                    },

                    {
                        name = "Blue Recessed Light",
                        model = "h4_prop_battle_lights_floorblue",
                        offset = { x = 0, y = 0, z = 0.75 },
                    },
                    {
                        name = "Red Recessed Light",
                        model = "h4_prop_battle_lights_floorred",
                        offset = { x = 0, y = 0, z = 0.75 },
                    },
                    {
                        name = "Red/Blue Pair of Recessed Lights",
                        model = "h4_prop_battle_lights_floorred",
                        offset = { x = 0.3, y = 0, z = 1 },
                        children = {
                            {
                                model = "h4_prop_battle_lights_floorblue",
                                reflection_axis = { x = true, y = false, z = false },
                            }
                        }
                    },
                    {
                        name = "Blue/Red Pair of Recessed Lights",
                        model = "h4_prop_battle_lights_floorblue",
                        offset = { x = 0.3, y = 0, z = 1 },
                        children = {
                            {
                                model = "h4_prop_battle_lights_floorred",
                                reflection_axis = { x = true, y = false, z = false },
                            }
                        }
                    },

                    -- Flashing is still kinda wonky for networking
                    {
                        name = "Flashing Recessed Lights",
                        model = "h4_prop_battle_lights_floorred",
                        offset = { x = 0.3, y = 0, z = 1 },
                        flash_start_on = false,
                        children = {
                            {
                                model = "h4_prop_battle_lights_floorblue",
                                reflection_axis = { x = true, y = false, z = false },
                                flash_start_on = true,
                            }
                        }
                    },
                    {
                        name = "Alternating Pair of Recessed Lights",
                        model = "h4_prop_battle_lights_floorred",
                        offset = { x = 0.3, y = 0, z = 1 },
                        flash_start_on = true,
                        children = {
                            {
                                model = "h4_prop_battle_lights_floorred",
                                reflection_axis = { x = true, y = false, z = false },
                                flash_start_on = false,
                                children = {
                                    {
                                        model = "h4_prop_battle_lights_floorblue",
                                        flash_start_on = true,
                                    }
                                }
                            },
                            {
                                model = "h4_prop_battle_lights_floorblue",
                                flash_start_on = true,
                            }
                        }
                    },

                    {
                        name = "Red Disc Light",
                        model = "prop_runlight_r",
                        offset = { x = 0, y = 0, z = 1 },
                    },
                    {
                        name = "Blue Disc Light",
                        model = "prop_runlight_b",
                        offset = { x = 0, y = 0, z = 1 },
                    },

                    {
                        name = "Blue Pole Light",
                        model = "prop_air_lights_02a",
                        offset = { x = 0, y = 0, z = 1 },
                    },
                    {
                        name = "Red Pole Light",
                        model = "prop_air_lights_02b",
                        offset = { x = 0, y = 0, z = 1 },
                    },

                    {
                        name = "Red Angled Light",
                        model = "prop_air_lights_04a",
                        offset = { x = 0, y = 0, z = 1 },
                    },
                    {
                        name = "Blue Angled Light",
                        model = "prop_air_lights_05a",
                        offset = { x = 0, y = 0, z = 1 },
                    },

                    {
                        name = "Cone Light",
                        model = "prop_air_conelight",
                        offset = { x = 0, y = 0, z = 1 },
                        rotation = { x = 0, y = 0, z = 0 },
                    },

                    -- This is actually 2 lights, spaced 20 feet apart.
                    --{
                    --    name="Blinking Red Light",
                    --    model="hei_prop_carrier_docklight_01",
                    --}
                },
            },
            {
                name = "Police",
                is_folder = true,
                items = {
                    {
                        name = "Riot Shield",
                        model = "prop_riot_shield",
                        rotation = { x = 180, y = 180, z = 0 },
                    },
                    {
                        name = "Ballistic Shield",
                        model = "prop_ballistic_shield",
                        rotation = { x = 180, y = 180, z = 0 },
                    },
                    {
                        name = "Minigun",
                        model = "prop_minigun_01",
                        rotation = { x = 0, y = 0, z = 90 },
                    },
                    {
                        name = "Monitor Screen",
                        model = "hei_prop_hei_monitor_police_01",
                    },
                    {
                        name = "Bomb",
                        model = "prop_ld_bomb_anim",
                    },
                    {
                        name = "Bomb (open)",
                        model = "prop_ld_bomb_01_open",
                    },
                },
            },
            {
                name = "Vehicle Objects",
                is_folder = true,
                items = {
                    {
                        name = "Aircraft Carrier",
                        model = "prop_temp_carrier"
                    },
                    {
                        name = "Commercial Jet",
                        model = "p_med_jet_01_s"
                    },
                    {
                        name = "Military Jet",
                        model = "hei_prop_carrier_jet"
                    },
                    {
                        name = "Tugboat",
                        model = "hei_prop_heist_tug"
                    },
                    {
                        name = "UFO",
                        model = "imp_prop_ship_01a"
                    },
                    {
                        name = "Yacht",
                        model = "apa_mp_apa_yacht"
                    },
                }
            },
            {
                name = "Animated Objects",
                is_folder = true,
                items = {
                    {
                        name = "Radar Dish",
                        model = "hei_prop_carrier_radar_1_l1"
                    },
                    {
                        name = "UFO",
                        model = "p_spinning_anus_s"
                    },
                    {
                        name = "Wacky Arm Waving Inflatable Tube Man",
                        model = "prop_airdancer_2_cloth"
                    },
                }
            },
            items = {
                name = "Fun",
                is_folder = true,
                items = {
                    {
                        name = "ATM",
                        model = "prop_atm_01"
                    },
                    {
                        name = "Bomb",
                        model = "imp_prop_bomb_ball"
                    },
                    {
                        name = "Car wheel",
                        model = "imp_prop_impexp_tyre_01c"
                    },
                    {
                        name = "Ferris wheel",
                        model = "p_ferris_wheel_amo_l"
                    },
                    {
                        name = "Guitar",
                        model = "prop_acc_guitar_01"
                    },
                    {
                        name = "Pile o' cash",
                        model = "bkr_prop_bkr_cashpile_01"
                    },
                    {
                        name = "Shipping container",
                        model = "port_xr_cont_01"
                    },
                    {
                        name = "Weed plant",
                        model = "bkr_prop_weed_lrg_01b"
                    },
                    {
                        name = "Wood crate",
                        model = "ng_proc_crate_04a"
                    },
                },
            },
        },
    },
    {
        name = "Vehicles",
        is_folder = true,
        items = {
            {
                is_folder = true,
                items = { {
                              hash = 2485144969,
                              name = "Asea",
                              type = "VEHICLE"
                          }, {
                              hash = 2487343317,
                              name = "Asea",
                              type = "VEHICLE"
                          }, {
                              hash = 2391954683,
                              name = "Asterope",
                              type = "VEHICLE"
                          }, {
                              hash = 2767531027,
                              name = "Cinquemila",
                              type = "VEHICLE"
                          }, {
                              hash = 906642318,
                              name = "Cognoscenti 55",
                              type = "VEHICLE"
                          }, {
                              hash = 704435172,
                              name = "Cognoscenti 55 (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 2264796000,
                              name = "Cognoscenti",
                              type = "VEHICLE"
                          }, {
                              hash = 3690124666,
                              name = "Cognoscenti (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 1532171089,
                              name = "Deity",
                              type = "VEHICLE"
                          }, {
                              hash = 3609690755,
                              name = "Emperor",
                              type = "VEHICLE"
                          }, {
                              hash = 2411965148,
                              name = "Emperor",
                              type = "VEHICLE"
                          }, {
                              hash = 3053254478,
                              name = "Emperor",
                              type = "VEHICLE"
                          }, {
                              hash = 1909141499,
                              name = "Fugitive",
                              type = "VEHICLE"
                          }, {
                              hash = 75131841,
                              name = "Glendale",
                              type = "VEHICLE"
                          }, {
                              hash = 3381377750,
                              name = "Glendale Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 3005245074,
                              name = "Ingot",
                              type = "VEHICLE"
                          }, {
                              hash = 886934177,
                              name = "Intruder",
                              type = "VEHICLE"
                          }, {
                              hash = 4180339789,
                              name = "Turreted Limo",
                              type = "VEHICLE"
                          }, {
                              hash = 2411098011,
                              name = "Premier",
                              type = "VEHICLE"
                          }, {
                              hash = 3144368207,
                              name = "Primo",
                              type = "VEHICLE"
                          }, {
                              hash = 2254540506,
                              name = "Primo Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 4280472072,
                              name = "Regina",
                              type = "VEHICLE"
                          }, {
                              hash = 2439462158,
                              name = "Rhinehart",
                              type = "VEHICLE"
                          }, {
                              hash = 627094268,
                              name = "Romero Hearse",
                              type = "VEHICLE"
                          }, {
                              hash = 3039514899,
                              name = "Schafter",
                              type = "VEHICLE"
                          }, {
                              hash = 3406724313,
                              name = "Schafter V12 (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 1922255844,
                              name = "Schafter LWB (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 321186144,
                              name = "Stafford",
                              type = "VEHICLE"
                          }, {
                              hash = 2817386317,
                              name = "Stanier",
                              type = "VEHICLE"
                          }, {
                              hash = 1723137093,
                              name = "Stratum",
                              type = "VEHICLE"
                          }, {
                              hash = 2333339779,
                              name = "Stretch",
                              type = "VEHICLE"
                          }, {
                              hash = 1123216662,
                              name = "Super Diamond",
                              type = "VEHICLE"
                          }, {
                              hash = 2400073108,
                              name = "Surge",
                              type = "VEHICLE"
                          }, {
                              hash = 3286105550,
                              name = "Tailgater",
                              type = "VEHICLE"
                          }, {
                              hash = 3050505892,
                              name = "Tailgater S",
                              type = "VEHICLE"
                          }, {
                              hash = 1373123368,
                              name = "Warrener",
                              type = "VEHICLE"
                          }, {
                              hash = 579912970,
                              name = "Warrener HKR",
                              type = "VEHICLE"
                          }, {
                              hash = 1777363799,
                              name = "Washington",
                              type = "VEHICLE"
                          }
                },
                name = "Sedan"
            }, {
                is_folder = true,
                items = { {
                              hash = 629969764,
                              name = "Astron",
                              type = "VEHICLE"
                          },
                    --{
                    --    hash = 2803699023,
                    --    name = "Astron Custom",
                    --    type = "VEHICLE"
                    --},
                          {
                              hash = 3486135912,
                              name = "Baller",
                              type = "VEHICLE"
                          }, {
                              hash = 142944341,
                              name = "Baller",
                              type = "VEHICLE"
                          }, {
                              hash = 1878062887,
                              name = "Baller LE",
                              type = "VEHICLE"
                          }, {
                              hash = 634118882,
                              name = "Baller LE LWB",
                              type = "VEHICLE"
                          }, {
                              hash = 470404958,
                              name = "Baller LE (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 666166960,
                              name = "Baller LE LWB (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 359875117,
                              name = "Baller ST",
                              type = "VEHICLE"
                          }, {
                              hash = 850565707,
                              name = "BeeJay XL",
                              type = "VEHICLE"
                          }, {
                              hash = 2006918058,
                              name = "Cavalcade",
                              type = "VEHICLE"
                          }, {
                              hash = 3505073125,
                              name = "Cavalcade",
                              type = "VEHICLE"
                          }, {
                              hash = 683047626,
                              name = "Contender",
                              type = "VEHICLE"
                          }, {
                              hash = 1177543287,
                              name = "Dubsta",
                              type = "VEHICLE"
                          }, {
                              hash = 3900892662,
                              name = "Dubsta",
                              type = "VEHICLE"
                          }, {
                              hash = 3157435195,
                              name = "FQ 2",
                              type = "VEHICLE"
                          }, {
                              hash = 2519238556,
                              name = "Granger",
                              type = "VEHICLE"
                          }, {
                              hash = 4033620423,
                              name = "Granger 3600LX",
                              type = "VEHICLE"
                          }, {
                              hash = 2751205197,
                              name = "Gresley",
                              type = "VEHICLE"
                          }, {
                              hash = 884422927,
                              name = "Habanero",
                              type = "VEHICLE"
                          }, {
                              hash = 486987393,
                              name = "Huntley S",
                              type = "VEHICLE"
                          }, {
                              hash = 662793086,
                              name = "I-Wagen",
                              type = "VEHICLE"
                          }, {
                              hash = 1550581940,
                              name = "Issi Rally",
                              type = "VEHICLE"
                          }, {
                              hash = 461465043,
                              name = "Jubilee",
                              type = "VEHICLE"
                          }, {
                              hash = 1269098716,
                              name = "Landstalker",
                              type = "VEHICLE"
                          }, {
                              hash = 3456868130,
                              name = "Landstalker XL",
                              type = "VEHICLE"
                          }, {
                              hash = 914654722,
                              name = "Mesa",
                              type = "VEHICLE"
                          }, {
                              hash = 3546958660,
                              name = "Mesa",
                              type = "VEHICLE"
                          }, {
                              hash = 2465530446,
                              name = "Novak",
                              type = "VEHICLE"
                          }, {
                              hash = 3486509883,
                              name = "Patriot",
                              type = "VEHICLE"
                          }, {
                              hash = 3874056184,
                              name = "Patriot Stretch",
                              type = "VEHICLE"
                          }, {
                              hash = 2643899483,
                              name = "Radius",
                              type = "VEHICLE"
                          }, {
                              hash = 83136452,
                              name = "Rebla GTS",
                              type = "VEHICLE"
                          }, {
                              hash = 2136773105,
                              name = "Rocoto",
                              type = "VEHICLE"
                          }, {
                              hash = 1221512915,
                              name = "Seminole",
                              type = "VEHICLE"
                          }, {
                              hash = 2484160806,
                              name = "Seminole Frontier",
                              type = "VEHICLE"
                          }, {
                              hash = 1337041428,
                              name = "Serrano",
                              type = "VEHICLE"
                          }, {
                              hash = 4192631813,
                              name = "Squaddie",
                              type = "VEHICLE"
                          }, {
                              hash = 3126015148,
                              name = "Toros",
                              type = "VEHICLE"
                          }, {
                              hash = 1203490606,
                              name = "XLS",
                              type = "VEHICLE"
                          }, {
                              hash = 3862958888,
                              name = "XLS (Armored)",
                              type = "VEHICLE"
                          } },
                name = "SUV"
            }, {
                is_folder = true,
                items = { {
                              hash = 330661258,
                              name = "Cognoscenti Cabrio",
                              type = "VEHICLE"
                          }, {
                              hash = 4289813342,
                              name = "Exemplar",
                              type = "VEHICLE"
                          }, {
                              hash = 3703357000,
                              name = "F620",
                              type = "VEHICLE"
                          }, {
                              hash = 3903372712,
                              name = "Felon",
                              type = "VEHICLE"
                          }, {
                              hash = 4205676014,
                              name = "Felon GT",
                              type = "VEHICLE"
                          }, {
                              hash = 3670438162,
                              name = "Jackal",
                              type = "VEHICLE"
                          }, {
                              hash = 4230891418,
                              name = "Kanjo SJ",
                              type = "VEHICLE"
                          }, {
                              hash = 1348744438,
                              name = "Oracle XS",
                              type = "VEHICLE"
                          }, {
                              hash = 3783366066,
                              name = "Oracle",
                              type = "VEHICLE"
                          }, {
                              hash = 4000288633,
                              name = "Postlude",
                              type = "VEHICLE"
                          }, {
                              hash = 1416471345,
                              name = "Previon",
                              type = "VEHICLE"
                          }, {
                              hash = 1349725314,
                              name = "Sentinel XS",
                              type = "VEHICLE"
                          }, {
                              hash = 873639469,
                              name = "Sentinel",
                              type = "VEHICLE"
                          }, {
                              hash = 1581459400,
                              name = "Windsor",
                              type = "VEHICLE"
                          }, {
                              hash = 2364918497,
                              name = "Windsor Drop",
                              type = "VEHICLE"
                          }, {
                              hash = 3172678083,
                              name = "Zion",
                              type = "VEHICLE"
                          }, {
                              hash = 3101863448,
                              name = "Zion Cabrio",
                              type = "VEHICLE"
                          } },
                name = "Coupe"
            }, {
                is_folder = true,
                items = { {
                              hash = 1549009676,
                              name = "Arbiter GT",
                              type = "VEHICLE"
                          }, {
                              hash = 3089165662,
                              name = "Blade",
                              type = "VEHICLE"
                          }, {
                              hash = 3612755468,
                              name = "Buccaneer",
                              type = "VEHICLE"
                          }, {
                              hash = 3281516360,
                              name = "Buccaneer Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2361724968,
                              name = "Broadway",
                              type = "VEHICLE"
                          },{
                              hash = 3675036420,
                              name = "Buffalo STX",
                              type = "VEHICLE"
                          }, {
                              hash = 349605904,
                              name = "Chino",
                              type = "VEHICLE"
                          }, {
                              hash = 2933279331,
                              name = "Chino Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2728360112,
                              name = "Clique",
                              type = "VEHICLE"
                          }, {
                              hash = 784565758,
                              name = "Coquette BlackFin",
                              type = "VEHICLE"
                          }, {
                              hash = 1279262537,
                              name = "Deviant",
                              type = "VEHICLE"
                          }, {
                              hash = 80636076,
                              name = "Dominator",
                              type = "VEHICLE"
                          }, {
                              hash = 3379262425,
                              name = "Pisswasser Dominator",
                              type = "VEHICLE"
                          }, {
                              hash = 3308022675,
                              name = "Dominator GTX",
                              type = "VEHICLE"
                          }, {
                              hash = 3606777648,
                              name = "Apocalypse Dominator",
                              type = "VEHICLE"
                          }, {
                              hash = 2919906639,
                              name = "Future Shock Dominator",
                              type = "VEHICLE"
                          }, {
                              hash = 3001042683,
                              name = "Nightmare Dominator",
                              type = "VEHICLE"
                          }, {
                              hash = 426742808,
                              name = "Dominator ASP",
                              type = "VEHICLE"
                          }, {
                              hash = 736672010,
                              name = "Dominator GTT",
                              type = "VEHICLE"
                          }, {
                              hash = 723973206,
                              name = "Dukes",
                              type = "VEHICLE"
                          }, {
                              hash = 3968823444,
                              name = "Duke O'Death",
                              type = "VEHICLE"
                          }, {
                              hash = 2134119907,
                              name = "Beater Dukes",
                              type = "VEHICLE"
                          }, {
                              hash = 3027423925,
                              name = "Ellie",
                              type = "VEHICLE"
                          }, {
                              hash = 3045179290,
                              name = "Eudora",
                              type = "VEHICLE"
                          },{
                              hash = 2175389151,
                              name = "Faction",
                              type = "VEHICLE"
                          }, {
                              hash = 2504420315,
                              name = "Faction Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2255212070,
                              name = "Faction Custom Donk",
                              type = "VEHICLE"
                          }, {
                              hash = 2494797253,
                              name = "Gauntlet",
                              type = "VEHICLE"
                          }, {
                              hash = 349315417,
                              name = "Redwood Gauntlet",
                              type = "VEHICLE"
                          }, {
                              hash = 722226637,
                              name = "Gauntlet Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 1934384720,
                              name = "Gauntlet Hellfire",
                              type = "VEHICLE"
                          }, {
                              hash = 2172320429,
                              name = "Gauntlet Classic Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 40817712,
                              name = "Greenwood",
                              type = "VEHICLE"
                          }, {
                              hash = 15219735,
                              name = "Hermes",
                              type = "VEHICLE"
                          }, {
                              hash = 37348240,
                              name = "Hotknife",
                              type = "VEHICLE"
                          }, {
                              hash = 600450546,
                              name = "Hustler",
                              type = "VEHICLE"
                          }, {
                              hash = 2198276962,
                              name = "Impaler",
                              type = "VEHICLE"
                          }, {
                              hash = 1009171724,
                              name = "Apocalypse Impaler",
                              type = "VEHICLE"
                          }, {
                              hash = 2370166601,
                              name = "Future Shock Impaler",
                              type = "VEHICLE"
                          }, {
                              hash = 2550461639,
                              name = "Nightmare Impaler",
                              type = "VEHICLE"
                          }, {
                              hash = 444994115,
                              name = "Apocalypse Imperator",
                              type = "VEHICLE"
                          }, {
                              hash = 1637620610,
                              name = "Future Shock Imperator",
                              type = "VEHICLE"
                          }, {
                              hash = 3539435063,
                              name = "Nightmare Imperator",
                              type = "VEHICLE"
                          }, {
                              hash = 2068293287,
                              name = "Lurcher",
                              type = "VEHICLE"
                          }, {
                              hash = 1717532765,
                              name = "Manana Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 525509695,
                              name = "Moonbeam",
                              type = "VEHICLE"
                          }, {
                              hash = 1896491931,
                              name = "Moonbeam Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2351681756,
                              name = "Nightshade",
                              type = "VEHICLE"
                          }, {
                              hash = 2490551588,
                              name = "Peyote Gasser",
                              type = "VEHICLE"
                          }, {
                              hash = 2199527893,
                              name = "Phoenix",
                              type = "VEHICLE"
                          }, {
                              hash = 1507916787,
                              name = "Picador",
                              type = "VEHICLE"
                          }, {
                              hash = 3627815886,
                              name = "Rat-Loader",
                              type = "VEHICLE"
                          }, {
                              hash = 3705788919,
                              name = "Rat-Truck",
                              type = "VEHICLE"
                          }, {
                              hash = 4067225593,
                              name = "Ruiner",
                              type = "VEHICLE"
                          }, {
                              hash = 941494461,
                              name = "Ruiner 2000",
                              type = "VEHICLE"
                          }, {
                              hash = 777714999,
                              name = "Ruiner",
                              type = "VEHICLE"
                          }, {
                              hash = 1706945532,
                              name = "Ruiner ZZ-8",
                              type = "VEHICLE"
                          }, {
                              hash = 2609945748,
                              name = "Sabre Turbo",
                              type = "VEHICLE"
                          }, {
                              hash = 223258115,
                              name = "Sabre Turbo Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 729783779,
                              name = "Slamvan",
                              type = "VEHICLE"
                          }, {
                              hash = 833469436,
                              name = "Lost Slamvan",
                              type = "VEHICLE"
                          }, {
                              hash = 1119641113,
                              name = "Slamvan Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2233918197,
                              name = "Apocalypse Slamvan",
                              type = "VEHICLE"
                          }, {
                              hash = 373261600,
                              name = "Future Shock Slamvan",
                              type = "VEHICLE"
                          }, {
                              hash = 1742022738,
                              name = "Nightmare Slamvan",
                              type = "VEHICLE"
                          }, {
                              hash = 1923400478,
                              name = "Stallion",
                              type = "VEHICLE"
                          }, {
                              hash = 3893323758,
                              name = "Burger Shot Stallion",
                              type = "VEHICLE"
                          }, {
                              hash = 3833117047,
                              name = "Tahoma Coupe",
                              type = "VEHICLE"
                          }, {
                              hash = 972671128,
                              name = "Tampa",
                              type = "VEHICLE"
                          }, {
                              hash = 3084515313,
                              name = "Weaponized Tampa",
                              type = "VEHICLE"
                          }, {
                              hash = 1456744817,
                              name = "Tulip",
                              type = "VEHICLE"
                          },{
                              hash = 268758436,
                              name = "Tulip M-100",
                              type = "VEHICLE"
                          }, {
                              hash = 4245851645,
                              name = "Vamos",
                              type = "VEHICLE"
                          }, {
                              hash = 3469130167,
                              name = "Vigero",
                              type = "VEHICLE"
                          }, {
                              hash = 2536587772,
                              name = "Vigero ZX",
                              type = "VEHICLE"
                          }, {
                              hash = 3796912450,
                              name = "Virgo",
                              type = "VEHICLE"
                          }, {
                              hash = 3395457658,
                              name = "Virgo Classic Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 16646064,
                              name = "Virgo Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 2006667053,
                              name = "Voodoo Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 523724515,
                              name = "Voodoo",
                              type = "VEHICLE"
                          }, {
                              hash = 3300595976,
                              name = "Weevil Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1871995513,
                              name = "Yosemite",
                              type = "VEHICLE"
                          }, {
                              hash = 1693751655,
                              name = "Drift Yosemite",
                              type = "VEHICLE"
                          } },
                name = "Muscle"
            }, {
                is_folder = true,
                items = { {
                              hash = 159274291,
                              name = "Ardent",
                              type = "VEHICLE"
                          }, {
                              hash = 117401876,
                              name = "Roosevelt",
                              type = "VEHICLE"
                          }, {
                              hash = 3463132580,
                              name = "Fränken Stange",
                              type = "VEHICLE"
                          }, {
                              hash = 3692679425,
                              name = "Roosevelt Valor",
                              type = "VEHICLE"
                          }, {
                              hash = 941800958,
                              name = "Casco",
                              type = "VEHICLE"
                          }, {
                              hash = 3306466016,
                              name = "Cheburek",
                              type = "VEHICLE"
                          }, {
                              hash = 223240013,
                              name = "Cheetah Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 1011753235,
                              name = "Coquette Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 1483171323,
                              name = "Deluxo",
                              type = "VEHICLE"
                          }, {
                              hash = 310284501,
                              name = "Dynasty",
                              type = "VEHICLE"
                          }, {
                              hash = 1617472902,
                              name = "Fagaloa",
                              type = "VEHICLE"
                          }, {
                              hash = 2728226064,
                              name = "Stirling GT",
                              type = "VEHICLE"
                          }, {
                              hash = 2215179066,
                              name = "GT500",
                              type = "VEHICLE"
                          }, {
                              hash = 2889029532,
                              name = "Infernus Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 1051415893,
                              name = "JB 700",
                              type = "VEHICLE"
                          }, {
                              hash = 394110044,
                              name = "JB 700W",
                              type = "VEHICLE"
                          }, {
                              hash = 2634021974,
                              name = "Mamba",
                              type = "VEHICLE"
                          }, {
                              hash = 2170765704,
                              name = "Manana",
                              type = "VEHICLE"
                          }, {
                              hash = 1046206681,
                              name = "Michelli GT",
                              type = "VEHICLE"
                          }, {
                              hash = 3861591579,
                              name = "Monroe",
                              type = "VEHICLE"
                          }, {
                              hash = 3412338231,
                              name = "Nebula Turbo",
                              type = "VEHICLE"
                          }, {
                              hash = 1830407356,
                              name = "Peyote",
                              type = "VEHICLE"
                          }, {
                              hash = 1107404867,
                              name = "Peyote Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1078682497,
                              name = "Pigalle",
                              type = "VEHICLE"
                          }, {
                              hash = 2049897956,
                              name = "Rapid GT Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 1841130506,
                              name = "Retinue",
                              type = "VEHICLE"
                          }, {
                              hash = 2031587082,
                              name = "Retinue Mk II",
                              type = "VEHICLE"
                          }, {
                              hash = 903794909,
                              name = "Savestra",
                              type = "VEHICLE"
                          }, {
                              hash = 1545842587,
                              name = "Stinger",
                              type = "VEHICLE"
                          }, {
                              hash = 2196019706,
                              name = "Stinger GT",
                              type = "VEHICLE"
                          }, {
                              hash = 886810209,
                              name = "Stromberg",
                              type = "VEHICLE"
                          }, {
                              hash = 500482303,
                              name = "Swinger",
                              type = "VEHICLE"
                          }, {
                              hash = 1455990255,
                              name = "Toreador",
                              type = "VEHICLE"
                          }, {
                              hash = 1504306544,
                              name = "Torero",
                              type = "VEHICLE"
                          }, {
                              hash = 464687292,
                              name = "Tornado",
                              type = "VEHICLE"
                          }, {
                              hash = 1531094468,
                              name = "Tornado",
                              type = "VEHICLE"
                          }, {
                              hash = 1762279763,
                              name = "Tornado",
                              type = "VEHICLE"
                          }, {
                              hash = 2261744861,
                              name = "Tornado",
                              type = "VEHICLE"
                          }, {
                              hash = 2497353967,
                              name = "Tornado Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2736567667,
                              name = "Tornado Rat Rod",
                              type = "VEHICLE"
                          }, {
                              hash = 3312836369,
                              name = "Turismo Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 3903371924,
                              name = "Viseris",
                              type = "VEHICLE"
                          }, {
                              hash = 838982985,
                              name = "190z",
                              type = "VEHICLE"
                          }, {
                              hash = 1862507111,
                              name = "Zion Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 758895617,
                              name = "Z-Type",
                              type = "VEHICLE"
                          } },
                name = "Sport Classic"
            }, {
                is_folder = true,
                items = { {
                              hash = 767087018,
                              name = "Alpha",
                              type = "VEHICLE"
                          }, {
                              hash = 3253274834,
                              name = "Banshee",
                              type = "VEHICLE"
                          }, {
                              hash = 1274868363,
                              name = "Bestia GTS",
                              type = "VEHICLE"
                          }, {
                              hash = 1039032026,
                              name = "Blista Compact",
                              type = "VEHICLE"
                          }, {
                              hash = 3703315515,
                              name = "Go Go Monkey Blista",
                              type = "VEHICLE"
                          }, {
                              hash = 3990165190,
                              name = "Buffalo",
                              type = "VEHICLE"
                          }, {
                              hash = 736902334,
                              name = "Buffalo S",
                              type = "VEHICLE"
                          }, {
                              hash = 237764926,
                              name = "Sprunk Buffalo",
                              type = "VEHICLE"
                          }, {
                              hash = 3101054893,
                              name = "Calico GTF",
                              type = "VEHICLE"
                          }, {
                              hash = 2072687711,
                              name = "Carbonizzare",
                              type = "VEHICLE"
                          }, {
                              hash = 3249425686,
                              name = "Comet",
                              type = "VEHICLE"
                          }, {
                              hash = 2272483501,
                              name = "Comet Retro Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1561920505,
                              name = "Comet Safari",
                              type = "VEHICLE"
                          }, {
                              hash = 661493923,
                              name = "Comet SR",
                              type = "VEHICLE"
                          }, {
                              hash = 2568944644,
                              name = "Comet S2",
                              type = "VEHICLE"
                          }, {
                              hash = 1141395928,
                              name = "Comet S2 Cabrio",
                              type = "VEHICLE"
                          }, {
                              hash = 108773431,
                              name = "Coquette",
                              type = "VEHICLE"
                          }, {
                              hash = 2566281822,
                              name = "Coquette D10",
                              type = "VEHICLE"
                          }, {
                              hash = 3540279623,
                              name = "Corsita",
                              type = "VEHICLE"
                          }, {
                              hash = 1755697647,
                              name = "Cypher",
                              type = "VEHICLE"
                          }, {
                              hash = 686471183,
                              name = "8F Drafter",
                              type = "VEHICLE"
                          }, {
                              hash = 196747873,
                              name = "Elegy Retro Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 3728579874,
                              name = "Elegy RH8",
                              type = "VEHICLE"
                          }, {
                              hash = 2038480341,
                              name = "Euros",
                              type = "VEHICLE"
                          }, {
                              hash = 2299640309,
                              name = "Feltzer",
                              type = "VEHICLE"
                          }, {
                              hash = 3035832600,
                              name = "Flash GT",
                              type = "VEHICLE"
                          }, {
                              hash = 3205927392,
                              name = "Furore GT",
                              type = "VEHICLE"
                          }, {
                              hash = 499169875,
                              name = "Fusilade",
                              type = "VEHICLE"
                          }, {
                              hash = 2016857647,
                              name = "Futo",
                              type = "VEHICLE"
                          }, {
                              hash = 2787736776,
                              name = "Futo GTX",
                              type = "VEHICLE"
                          }, {
                              hash = 1909189272,
                              name = "GB200",
                              type = "VEHICLE"
                          }, {
                              hash = 1304459735,
                              name = "Growler",
                              type = "VEHICLE"
                          },{
                              hash = 4163619118,
                              name = "Hotring Everon",
                              type = "VEHICLE"
                          }, {
                              hash = 1115909093,
                              name = "Hotring Sabre",
                              type = "VEHICLE"
                          }, {
                              hash = 3162245632,
                              name = "Imorgon",
                              type = "VEHICLE"
                          }, {
                              hash = 1854776567,
                              name = "Issi",
                              type = "VEHICLE"
                          }, {
                              hash = 3963499524,
                              name = "Itali GTO",
                              type = "VEHICLE"
                          }, {
                              hash = 3145241962,
                              name = "Itali RSX",
                              type = "VEHICLE"
                          }, {
                              hash = 2997294755,
                              name = "Jester",
                              type = "VEHICLE"
                          }, {
                              hash = 3188613414,
                              name = "Jester (Racecar)",
                              type = "VEHICLE"
                          }, {
                              hash = 4080061290,
                              name = "Jester Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 2712905841,
                              name = "Jester RR",
                              type = "VEHICLE"
                          }, {
                              hash = 4086055493,
                              name = "Jugular",
                              type = "VEHICLE"
                          }, {
                              hash = 544021352,
                              name = "Khamelion",
                              type = "VEHICLE"
                          }, {
                              hash = 3460613305,
                              name = "Komoda",
                              type = "VEHICLE"
                          }, {
                              hash = 2922118804,
                              name = "Kuruma",
                              type = "VEHICLE"
                          }, {
                              hash = 410882957,
                              name = "Kuruma (armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 3353694737,
                              name = "Locust",
                              type = "VEHICLE"
                          }, {
                              hash = 482197771,
                              name = "Lynx",
                              type = "VEHICLE"
                          }, {
                              hash = 4152024626,
                              name = "Massacro",
                              type = "VEHICLE"
                          }, {
                              hash = 3663206819,
                              name = "Massacro (Racecar)",
                              type = "VEHICLE"
                          }, {
                              hash = 2674840994,
                              name = "Neo",
                              type = "VEHICLE"
                          }, {
                              hash = 2445973230,
                              name = "Neon",
                              type = "VEHICLE"
                          }, {
                              hash = 1032823388,
                              name = "9F",
                              type = "VEHICLE"
                          }, {
                              hash = 2833484545,
                              name = "9F Cabrio",
                              type = "VEHICLE"
                          }, {
                              hash = 3517794615,
                              name = "Omnis",
                              type = "VEHICLE"
                          }, {
                              hash = 3789743831,
                              name = "Omnis e-GT",
                              type = "VEHICLE"
                          },{
                              hash = 2100457220,
                              name = "Panthere",
                              type = "VEHICLE"
                          }, {
                              hash = 3847255899,
                              name = "Paragon R",
                              type = "VEHICLE"
                          }, {
                              hash = 1416466158,
                              name = "Paragon R (Armored)",
                              type = "VEHICLE"
                          }, {
                              hash = 867799010,
                              name = "Pariah",
                              type = "VEHICLE"
                          }, {
                              hash = 3917501776,
                              name = "Penumbra",
                              type = "VEHICLE"
                          }, {
                              hash = 3663644634,
                              name = "Penumbra FF",
                              type = "VEHICLE"
                          },{
                              hash = 1076201208,
                              name = "300R",
                              type = "VEHICLE"
                          }, {
                              hash = 2765724541,
                              name = "Raiden",
                              type = "VEHICLE"
                          }, {
                              hash = 2360515092,
                              name = "Rapid GT",
                              type = "VEHICLE"
                          }, {
                              hash = 1737773231,
                              name = "Rapid GT",
                              type = "VEHICLE"
                          }, {
                              hash = 3620039993,
                              name = "Raptor",
                              type = "VEHICLE"
                          }, {
                              hash = 1377217886,
                              name = "Remus",
                              type = "VEHICLE"
                          }, {
                              hash = 3884762073,
                              name = "Revolter",
                              type = "VEHICLE"
                          }, {
                              hash = 3842363289,
                              name = "RT3000",
                              type = "VEHICLE"
                          }, {
                              hash = 719660200,
                              name = "Ruston",
                              type = "VEHICLE"
                          }, {
                              hash = 1133471123,
                              name = "S95",
                              type = "VEHICLE"
                          }, {
                              hash = 2809443750,
                              name = "Schafter V12",
                              type = "VEHICLE"
                          }, {
                              hash = 1489967196,
                              name = "Schafter LWB",
                              type = "VEHICLE"
                          }, {
                              hash = 3787471536,
                              name = "Schlagen GT",
                              type = "VEHICLE"
                          }, {
                              hash = 3548084598,
                              name = "Schwartzer",
                              type = "VEHICLE"
                          }, {
                              hash = 1104234922,
                              name = "Sentinel",
                              type = "VEHICLE"
                          }, {
                              hash = 2938086457,
                              name = "Sentinel Classic Widebody",
                              type = "VEHICLE"
                          }, {
                              hash = 2537130571,
                              name = "Seven-70",
                              type = "VEHICLE"
                          }, {
                              hash = 775514032,
                              name = "SM722",
                              type = "VEHICLE"
                          }, {
                              hash = 1886268224,
                              name = "Specter",
                              type = "VEHICLE"
                          }, {
                              hash = 1074745671,
                              name = "Specter Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1741861769,
                              name = "Streiter",
                              type = "VEHICLE"
                          }, {
                              hash = 987469656,
                              name = "Sugoi",
                              type = "VEHICLE"
                          }, {
                              hash = 970598228,
                              name = "Sultan",
                              type = "VEHICLE"
                          }, {
                              hash = 872704284,
                              name = "Sultan Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 4003946083,
                              name = "Sultan RS Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 384071873,
                              name = "Surano",
                              type = "VEHICLE"
                          }, {
                              hash = 3223586949,
                              name = "Drift Tampa",
                              type = "VEHICLE"
                          }, {
                              hash = 3400983137,
                              name = "10F",
                              type = "VEHICLE"
                          }, {
                              hash = 274946574,
                              name = "10F Widebody",
                              type = "VEHICLE"
                          }, {
                              hash = 1887331236,
                              name = "Tropos Rallye",
                              type = "VEHICLE"
                          }, {
                              hash = 2754593701,
                              name = "Vectre",
                              type = "VEHICLE"
                          }, {
                              hash = 1102544804,
                              name = "Verlierer",
                              type = "VEHICLE"
                          }, {
                              hash = 3437611258,
                              name = "Veto Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 2802050217,
                              name = "Veto Modern",
                              type = "VEHICLE"
                          }, {
                              hash = 1456336509,
                              name = "V-STR",
                              type = "VEHICLE"
                          }, {
                              hash = 2436313176,
                              name = "ZR350",
                              type = "VEHICLE"
                          }, {
                              hash = 540101442,
                              name = "Apocalypse ZR380",
                              type = "VEHICLE"
                          }, {
                              hash = 3188846534,
                              name = "Future Shock ZR380",
                              type = "VEHICLE"
                          }, {
                              hash = 2816263004,
                              name = "Nightmare ZR380",
                              type = "VEHICLE"
                          } },
                name = "Sport"
            }, {
                is_folder = true,
                items = { {
                              hash = 3078201489,
                              name = "Adder",
                              type = "VEHICLE"
                          }, {
                              hash = 3981782132,
                              name = "Autarch",
                              type = "VEHICLE"
                          }, {
                              hash = 633712403,
                              name = "Banshee 900R",
                              type = "VEHICLE"
                          }, {
                              hash = 2598821281,
                              name = "Bullet",
                              type = "VEHICLE"
                          }, {
                              hash = 3379732821,
                              name = "Champion",
                              type = "VEHICLE"
                          }, {
                              hash = 2983812512,
                              name = "Cheetah",
                              type = "VEHICLE"
                          }, {
                              hash = 1392481335,
                              name = "Cyclone",
                              type = "VEHICLE"
                          }, {
                              hash = 386089410,
                              name = "Cyclone II",
                              type = "VEHICLE"
                          }, {
                              hash = 1591739866,
                              name = "Deveste Eight",
                              type = "VEHICLE"
                          }, {
                              hash = 1323778901,
                              name = "Emerus",
                              type = "VEHICLE"
                          }, {
                              hash = 1748565021,
                              name = "Entity MT",
                              type = "VEHICLE"
                          }, {
                              hash = 2174267100,
                              name = "Entity XXR",
                              type = "VEHICLE"
                          }, {
                              hash = 3003014393,
                              name = "Entity XF",
                              type = "VEHICLE"
                          }, {
                              hash = 1426219628,
                              name = "FMJ",
                              type = "VEHICLE"
                          }, {
                              hash = 960812448,
                              name = "Furia",
                              type = "VEHICLE"
                          }, {
                              hash = 1234311532,
                              name = "GP1",
                              type = "VEHICLE"
                          }, {
                              hash = 2850852987,
                              name = "Ignus",
                              type = "VEHICLE"
                          }, {
                              hash = 956849991,
                              name = "Weaponized Ignus",
                              type = "VEHICLE"
                          }, {
                              hash = 418536135,
                              name = "Infernus",
                              type = "VEHICLE"
                          }, {
                              hash = 2246633323,
                              name = "Itali GTB",
                              type = "VEHICLE"
                          }, {
                              hash = 3812247419,
                              name = "Itali GTB Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 3630826055,
                              name = "Krieger",
                              type = "VEHICLE"
                          }, {
                              hash = 3062131285,
                              name = "RE-7B",
                              type = "VEHICLE"
                          }, {
                              hash = 4284049613,
                              name = "LM87",
                              type = "VEHICLE"
                          }, {
                              hash = 1034187331,
                              name = "Nero",
                              type = "VEHICLE"
                          }, {
                              hash = 1093792632,
                              name = "Nero Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1987142870,
                              name = "Osiris",
                              type = "VEHICLE"
                          }, {
                              hash = 2536829930,
                              name = "Penetrator",
                              type = "VEHICLE"
                          }, {
                              hash = 2465164804,
                              name = "811",
                              type = "VEHICLE"
                          }, {
                              hash = 2123327359,
                              name = "X80 Proto",
                              type = "VEHICLE"
                          }, {
                              hash = 234062309,
                              name = "Reaper",
                              type = "VEHICLE"
                          }, {
                              hash = 3970348707,
                              name = "S80RR",
                              type = "VEHICLE"
                          }, {
                              hash = 1352136073,
                              name = "SC1",
                              type = "VEHICLE"
                          }, {
                              hash = 3656405053,
                              name = "Scramjet",
                              type = "VEHICLE"
                          }, {
                              hash = 819197656,
                              name = "ETR1",
                              type = "VEHICLE"
                          }, {
                              hash = 3999278268,
                              name = "Sultan RS",
                              type = "VEHICLE"
                          }, {
                              hash = 1663218586,
                              name = "T20",
                              type = "VEHICLE"
                          }, {
                              hash = 3160260734,
                              name = "Taipan",
                              type = "VEHICLE"
                          }, {
                              hash = 272929391,
                              name = "Tempesta",
                              type = "VEHICLE"
                          }, {
                              hash = 1031562256,
                              name = "Tezeract",
                              type = "VEHICLE"
                          }, {
                              hash = 1044193113,
                              name = "Thrax",
                              type = "VEHICLE"
                          }, {
                              hash = 2936769864,
                              name = "Tigon",
                              type = "VEHICLE"
                          }, {
                              hash = 4129572538,
                              name = "Torero XO",
                              type = "VEHICLE"
                          }, {
                              hash = 408192225,
                              name = "Turismo R",
                              type = "VEHICLE"
                          }, {
                              hash = 3918533058,
                              name = "Tyrant",
                              type = "VEHICLE"
                          }, {
                              hash = 2067820283,
                              name = "Tyrus",
                              type = "VEHICLE"
                          }, {
                              hash = 338562499,
                              name = "Vacca",
                              type = "VEHICLE"
                          }, {
                              hash = 1939284556,
                              name = "Vagner",
                              type = "VEHICLE"
                          }, {
                              hash = 3052358707,
                              name = "Vigilante",
                              type = "VEHICLE"
                          },{
                              hash = 669204833,
                              name = "Virtue",
                              type = "VEHICLE"
                          }, {
                              hash = 3296789504,
                              name = "Visione",
                              type = "VEHICLE"
                          }, {
                              hash = 2672523198,
                              name = "Voltic",
                              type = "VEHICLE"
                          }, {
                              hash = 989294410,
                              name = "Rocket Voltic",
                              type = "VEHICLE"
                          }, {
                              hash = 917809321,
                              name = "XA-21",
                              type = "VEHICLE"
                          }, {
                              hash = 655665811,
                              name = "Zeno",
                              type = "VEHICLE"
                          }, {
                              hash = 2891838741,
                              name = "Zentorno",
                              type = "VEHICLE"
                          }, {
                              hash = 3612858749,
                              name = "Zorrusso",
                              type = "VEHICLE"
                          } },
                name = "Super"
            }, {
                is_folder = true,
                items = { {
                              hash = 1672195559,
                              name = "Akuma",
                              type = "VEHICLE"
                          }, {
                              hash = 2179174271,
                              name = "Avarus",
                              type = "VEHICLE"
                          }, {
                              hash = 2154536131,
                              name = "Bagger",
                              type = "VEHICLE"
                          }, {
                              hash = 4180675781,
                              name = "Bati 801",
                              type = "VEHICLE"
                          }, {
                              hash = 3403504941,
                              name = "Bati 801RR",
                              type = "VEHICLE"
                          }, {
                              hash = 86520421,
                              name = "BF400",
                              type = "VEHICLE"
                          }, {
                              hash = 11251904,
                              name = "Carbon RS",
                              type = "VEHICLE"
                          }, {
                              hash = 6774487,
                              name = "Chimera",
                              type = "VEHICLE"
                          }, {
                              hash = 390201602,
                              name = "Cliffhanger",
                              type = "VEHICLE"
                          }, {
                              hash = 2006142190,
                              name = "Daemon",
                              type = "VEHICLE"
                          }, {
                              hash = 2890830793,
                              name = "Daemon",
                              type = "VEHICLE"
                          }, {
                              hash = 4267640610,
                              name = "Apocalypse Deathbike",
                              type = "VEHICLE"
                          }, {
                              hash = 2482017624,
                              name = "Future Shock Deathbike",
                              type = "VEHICLE"
                          }, {
                              hash = 2920466844,
                              name = "Nightmare Deathbike",
                              type = "VEHICLE"
                          }, {
                              hash = 822018448,
                              name = "Defiler",
                              type = "VEHICLE"
                          }, {
                              hash = 4055125828,
                              name = "Diabolus",
                              type = "VEHICLE"
                          }, {
                              hash = 1790834270,
                              name = "Diabolus Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2623969160,
                              name = "Double-T",
                              type = "VEHICLE"
                          }, {
                              hash = 1753414259,
                              name = "Enduro",
                              type = "VEHICLE"
                          }, {
                              hash = 2035069708,
                              name = "Esskey",
                              type = "VEHICLE"
                          }, {
                              hash = 2452219115,
                              name = "Faggio Sport",
                              type = "VEHICLE"
                          }, {
                              hash = 55628203,
                              name = "Faggio",
                              type = "VEHICLE"
                          }, {
                              hash = 3005788552,
                              name = "Faggio Mod",
                              type = "VEHICLE"
                          }, {
                              hash = 627535535,
                              name = "FCR 1000",
                              type = "VEHICLE"
                          }, {
                              hash = 3537231886,
                              name = "FCR 1000 Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 741090084,
                              name = "Gargoyle",
                              type = "VEHICLE"
                          }, {
                              hash = 1265391242,
                              name = "Hakuchou",
                              type = "VEHICLE"
                          }, {
                              hash = 4039289119,
                              name = "Hakuchou Drag",
                              type = "VEHICLE"
                          }, {
                              hash = 301427732,
                              name = "Hexer",
                              type = "VEHICLE"
                          }, {
                              hash = 4135840458,
                              name = "Innovation",
                              type = "VEHICLE"
                          }, {
                              hash = 640818791,
                              name = "Lectro",
                              type = "VEHICLE"
                          }, {
                              hash = 2771538552,
                              name = "Manchez",
                              type = "VEHICLE"
                          }, {
                              hash = 1086534307,
                              name = "Manchez Scout",
                              type = "VEHICLE"
                          },{
                              hash = 1384502824,
                              name = "Manchez Scout C",
                              type = "VEHICLE"
                          }, {
                              hash = 3660088182,
                              name = "Nemesis",
                              type = "VEHICLE"
                          }, {
                              hash = 2688780135,
                              name = "Nightblade",
                              type = "VEHICLE"
                          }, {
                              hash = 884483972,
                              name = "Oppressor",
                              type = "VEHICLE"
                          }, {
                              hash = 2069146067,
                              name = "Oppressor Mk II",
                              type = "VEHICLE"
                          }, {
                              hash = 2908631255,
                              name = "Powersurge",
                              type = "VEHICLE"
                          },{
                              hash = 3385765638,
                              name = "PCJ 600",
                              type = "VEHICLE"
                          }, {
                              hash = 1873600305,
                              name = "Rat Bike",
                              type = "VEHICLE"
                          }, {
                              hash = 1993851908,
                              name = "Reever",
                              type = "VEHICLE"
                          }, {
                              hash = 916547552,
                              name = "Rampant Rocket",
                              type = "VEHICLE"
                          }, {
                              hash = 3401388520,
                              name = "Ruffian",
                              type = "VEHICLE"
                          }, {
                              hash = 788045382,
                              name = "Sanchez (livery)",
                              type = "VEHICLE"
                          }, {
                              hash = 2841686334,
                              name = "Sanchez",
                              type = "VEHICLE"
                          }, {
                              hash = 1491277511,
                              name = "Sanctus",
                              type = "VEHICLE"
                          }, {
                              hash = 1353120668,
                              name = "Shinobi",
                              type = "VEHICLE"
                          }, {
                              hash = 3889340782,
                              name = "Shotaro",
                              type = "VEHICLE"
                          }, {
                              hash = 743478836,
                              name = "Sovereign",
                              type = "VEHICLE"
                          }, {
                              hash = 301304410,
                              name = "Stryder",
                              type = "VEHICLE"
                          }, {
                              hash = 1836027715,
                              name = "Thrust",
                              type = "VEHICLE"
                          }, {
                              hash = 4154065143,
                              name = "Vader",
                              type = "VEHICLE"
                          }, {
                              hash = 2941886209,
                              name = "Vindicator",
                              type = "VEHICLE"
                          }, {
                              hash = 3685342204,
                              name = "Vortex",
                              type = "VEHICLE"
                          }, {
                              hash = 3676349299,
                              name = "Wolfsbane",
                              type = "VEHICLE"
                          }, {
                              hash = 3285698347,
                              name = "Zombie Bobber",
                              type = "VEHICLE"
                          }, {
                              hash = 3724934023,
                              name = "Zombie Chopper",
                              type = "VEHICLE"
                          } },
                name = "Motorcycle"
            }, {
                is_folder = true,
                items = { {
                              hash = 1126868326,
                              name = "Injection",
                              type = "VEHICLE"
                          }, {
                              hash = 3945366167,
                              name = "Bifta",
                              type = "VEHICLE"
                          }, {
                              hash = 2166734073,
                              name = "Blazer",
                              type = "VEHICLE"
                          }, {
                              hash = 4246935337,
                              name = "Blazer Lifeguard",
                              type = "VEHICLE"
                          }, {
                              hash = 3025077634,
                              name = "Hot Rod Blazer",
                              type = "VEHICLE"
                          }, {
                              hash = 3854198872,
                              name = "Street Blazer",
                              type = "VEHICLE"
                          }, {
                              hash = 2704629607,
                              name = "Blazer Aqua",
                              type = "VEHICLE"
                          }, {
                              hash = 2859047862,
                              name = "Bodhi",
                              type = "VEHICLE"
                          }, {
                              hash = 996383885,
                              name = "Boor",
                              type = "VEHICLE"
                          }, {
                              hash = 2815302597,
                              name = "Brawler",
                              type = "VEHICLE"
                          }, {
                              hash = 668439077,
                              name = "Apocalypse Bruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 2600885406,
                              name = "Future Shock Bruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 2252616474,
                              name = "Nightmare Bruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 2139203625,
                              name = "Apocalypse Brutus",
                              type = "VEHICLE"
                          }, {
                              hash = 2403970600,
                              name = "Future Shock Brutus",
                              type = "VEHICLE"
                          }, {
                              hash = 2038858402,
                              name = "Nightmare Brutus",
                              type = "VEHICLE"
                          }, {
                              hash = 1254014755,
                              name = "Caracara",
                              type = "VEHICLE"
                          }, {
                              hash = 2945871676,
                              name = "Caracara 4x4",
                              type = "VEHICLE"
                          }, {
                              hash = 1770332643,
                              name = "Duneloader",
                              type = "VEHICLE"
                          }, {
                              hash = 3526730918,
                              name = "Draugur",
                              type = "VEHICLE"
                          }, {
                              hash = 3057713523,
                              name = "Dubsta 6x6",
                              type = "VEHICLE"
                          }, {
                              hash = 2633113103,
                              name = "Dune Buggy",
                              type = "VEHICLE"
                          }, {
                              hash = 534258863,
                              name = "Space Docker",
                              type = "VEHICLE"
                          }, {
                              hash = 1897744184,
                              name = "Dune FAV",
                              type = "VEHICLE"
                          }, {
                              hash = 3467805257,
                              name = "Ramp Buggy",
                              type = "VEHICLE"
                          }, {
                              hash = 3982671785,
                              name = "Ramp Buggy",
                              type = "VEHICLE"
                          }, {
                              hash = 2538945576,
                              name = "Everon",
                              type = "VEHICLE"
                          }, {
                              hash = 4240635011,
                              name = "Freecrawler",
                              type = "VEHICLE"
                          }, {
                              hash = 3932816511,
                              name = "Hellion",
                              type = "VEHICLE"
                          }, {
                              hash = 2434067162,
                              name = "Insurgent Pick-Up",
                              type = "VEHICLE"
                          }, {
                              hash = 2071877360,
                              name = "Insurgent",
                              type = "VEHICLE"
                          }, {
                              hash = 2370534026,
                              name = "Insurgent Pick-Up Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 92612664,
                              name = "Kalahari",
                              type = "VEHICLE"
                          }, {
                              hash = 4173521127,
                              name = "Kamacho",
                              type = "VEHICLE"
                          }, {
                              hash = 1233534620,
                              name = "Marshall",
                              type = "VEHICLE"
                          }, {
                              hash = 2044532910,
                              name = "Menacer",
                              type = "VEHICLE"
                          }, {
                              hash = 2230595153,
                              name = "Mesa",
                              type = "VEHICLE"
                          }, {
                              hash = 3449006043,
                              name = "Monster",
                              type = "VEHICLE"
                          }, {
                              hash = 1721676810,
                              name = "Apocalypse Sasquatch",
                              type = "VEHICLE"
                          }, {
                              hash = 840387324,
                              name = "Future Shock Sasquatch",
                              type = "VEHICLE"
                          }, {
                              hash = 3579220348,
                              name = "Nightmare Sasquatch",
                              type = "VEHICLE"
                          }, {
                              hash = 433954513,
                              name = "Nightshark",
                              type = "VEHICLE"
                          }, {
                              hash = 408825843,
                              name = "Outlaw",
                              type = "VEHICLE"
                          }, {
                              hash = 3624880708,
                              name = "Patriot Mil-Spec",
                              type = "VEHICLE"
                          }, {
                              hash = 1645267888,
                              name = "Rancher XL",
                              type = "VEHICLE"
                          }, {
                              hash = 1933662059,
                              name = "Rancher XL",
                              type = "VEHICLE"
                          }, {
                              hash = 4008920556,
                              name = "RC Bandito",
                              type = "VEHICLE"
                          }, {
                              hash = 3087195462,
                              name = "Rusty Rebel",
                              type = "VEHICLE"
                          }, {
                              hash = 2249373259,
                              name = "Rebel",
                              type = "VEHICLE"
                          }, {
                              hash = 2762269779,
                              name = "Riata",
                              type = "VEHICLE"
                          }, {
                              hash = 3105951696,
                              name = "Sandking XL",
                              type = "VEHICLE"
                          }, {
                              hash = 989381445,
                              name = "Sandking SWB",
                              type = "VEHICLE"
                          }, {
                              hash = 2198148358,
                              name = "Technical",
                              type = "VEHICLE"
                          }, {
                              hash = 1180875963,
                              name = "Technical Aqua",
                              type = "VEHICLE"
                          }, {
                              hash = 1356124575,
                              name = "Technical Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 101905590,
                              name = "Trophy Truck",
                              type = "VEHICLE"
                          }, {
                              hash = 3631668194,
                              name = "Desert Raid",
                              type = "VEHICLE"
                          }, {
                              hash = 740289177,
                              name = "Vagrant",
                              type = "VEHICLE"
                          }, {
                              hash = 298565713,
                              name = "Verus",
                              type = "VEHICLE"
                          }, {
                              hash = 4084658662,
                              name = "Winky",
                              type = "VEHICLE"
                          }, {
                              hash = 67753863,
                              name = "Yosemite Rancher",
                              type = "VEHICLE"
                          }, {
                              hash = 1284356689,
                              name = "Zhaba",
                              type = "VEHICLE"
                          } },
                name = "Off Road"
            }, {
                is_folder = true,
                items = { {
                              hash = 1886712733,
                              name = "Dozer",
                              type = "VEHICLE"
                          }, {
                              hash = 3288047904,
                              name = "Cutter",
                              type = "VEHICLE"
                          }, {
                              hash = 2164484578,
                              name = "Dump",
                              type = "VEHICLE"
                          }, {
                              hash = 1353720154,
                              name = "Flatbed",
                              type = "VEHICLE"
                          }, {
                              hash = 2186977100,
                              name = "Guardian",
                              type = "VEHICLE"
                          }, {
                              hash = 444583674,
                              name = "Dock Handler",
                              type = "VEHICLE"
                          }, {
                              hash = 3510150843,
                              name = "Mixer",
                              type = "VEHICLE"
                          }, {
                              hash = 475220373,
                              name = "Mixer",
                              type = "VEHICLE"
                          }, {
                              hash = 2589662668,
                              name = "Rubble",
                              type = "VEHICLE"
                          }, {
                              hash = 48339065,
                              name = "Tipper",
                              type = "VEHICLE"
                          }, {
                              hash = 3347205726,
                              name = "Tipper",
                              type = "VEHICLE"
                          } },
                name = "Industrial"
            }, {
                is_folder = true,
                items = { {
                              hash = 1560980623,
                              name = "Airtug",
                              type = "VEHICLE"
                          }, {
                              hash = 3087536137,
                              name = "Army Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2818520053,
                              name = "Army Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2657817814,
                              name = "Army Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 3895125590,
                              name = "Baletrailer",
                              type = "VEHICLE"
                          }, {
                              hash = 524108981,
                              name = "Boat Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 1147287684,
                              name = "Caddy",
                              type = "VEHICLE"
                          }, {
                              hash = 3757070668,
                              name = "Caddy",
                              type = "VEHICLE"
                          }, {
                              hash = 3525819835,
                              name = "Caddy",
                              type = "VEHICLE"
                          }, {
                              hash = 2154757102,
                              type = "VEHICLE"
                          }, {
                              hash = 3410276810,
                              name = "Docktug",
                              type = "VEHICLE"
                          }, {
                              hash = 1491375716,
                              name = "Forklift",
                              type = "VEHICLE"
                          }, {
                              hash = 3517691494,
                              type = "VEHICLE"
                          }, {
                              hash = 1019737494,
                              name = "Graintrailer",
                              type = "VEHICLE"
                          }, {
                              hash = 1783355638,
                              name = "Lawn Mower",
                              type = "VEHICLE"
                          }, {
                              hash = 356391690,
                              type = "VEHICLE"
                          }, {
                              hash = 390902130,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 3448987385,
                              name = "Ripley",
                              type = "VEHICLE"
                          }, {
                              hash = 3695398481,
                              name = "Sadler",
                              type = "VEHICLE"
                          }, {
                              hash = 734217681,
                              name = "Sadler",
                              type = "VEHICLE"
                          }, {
                              hash = 2594165727,
                              name = "Scrap Truck",
                              type = "VEHICLE"
                          }, {
                              hash = 3249056020,
                              name = "Slamtruck",
                              type = "VEHICLE"
                          }, {
                              hash = 3564062519,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 1956216962,
                              type = "VEHICLE"
                          }, {
                              hash = 2971866336,
                              name = "Towtruck",
                              type = "VEHICLE"
                          }, {
                              hash = 3852654278,
                              name = "Towtruck",
                              type = "VEHICLE"
                          }, {
                              hash = 2078290630,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 1784254509,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2091594960,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 1641462412,
                              name = "Tractor",
                              type = "VEHICLE"
                          }, {
                              hash = 2218488798,
                              name = "Fieldmaster",
                              type = "VEHICLE"
                          }, {
                              hash = 1445631933,
                              name = "Fieldmaster",
                              type = "VEHICLE"
                          }, {
                              hash = 1502869817,
                              name = "Mobile Operations Center",
                              type = "VEHICLE"
                          }, {
                              hash = 2016027501,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 3417488910,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2715434129,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2236089197,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 3194418602,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 712162987,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2942498482,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2524324030,
                              name = "Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 516990260,
                              name = "Utility Truck",
                              type = "VEHICLE"
                          }, {
                              hash = 887537515,
                              name = "Utility Truck",
                              type = "VEHICLE"
                          }, {
                              hash = 2132890591,
                              name = "Utility Truck",
                              type = "VEHICLE"
                          } },
                name = "Utility"
            }, {
                is_folder = true,
                items = { {
                              hash = 4278019151,
                              name = "Bison",
                              type = "VEHICLE"
                          }, {
                              hash = 2072156101,
                              name = "Bison",
                              type = "VEHICLE"
                          }, {
                              hash = 1739845664,
                              name = "Bison",
                              type = "VEHICLE"
                          }, {
                              hash = 1069929536,
                              name = "Bobcat XL",
                              type = "VEHICLE"
                          }, {
                              hash = 2307837162,
                              name = "Boxville",
                              type = "VEHICLE"
                          }, {
                              hash = 4061868990,
                              name = "Boxville",
                              type = "VEHICLE"
                          }, {
                              hash = 121658888,
                              name = "Boxville",
                              type = "VEHICLE"
                          }, {
                              hash = 444171386,
                              name = "Boxville",
                              type = "VEHICLE"
                          }, {
                              hash = 682434785,
                              name = "Armored Boxville",
                              type = "VEHICLE"
                          }, {
                              hash = 2948279460,
                              name = "Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 3387490166,
                              name = "Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 2551651283,
                              name = "Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 893081117,
                              name = "Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 1132262048,
                              name = "Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 1876516712,
                              name = "Camper",
                              type = "VEHICLE"
                          }, {
                              hash = 2549763894,
                              name = "Gang Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 296357396,
                              name = "Gang Burrito",
                              type = "VEHICLE"
                          }, {
                              hash = 4174679674,
                              name = "Journey",
                              type = "VEHICLE"
                          },{
                              hash = 2667889793,
                              name = "Journey II",
                              type = "VEHICLE"
                          }, {
                              hash = 3984502180,
                              name = "Minivan",
                              type = "VEHICLE"
                          }, {
                              hash = 3168702960,
                              name = "Minivan Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1488164764,
                              name = "Paradise",
                              type = "VEHICLE"
                          }, {
                              hash = 4175309224,
                              name = "Pony",
                              type = "VEHICLE"
                          }, {
                              hash = 943752001,
                              name = "Pony",
                              type = "VEHICLE"
                          }, {
                              hash = 1162065741,
                              name = "Rumpo",
                              type = "VEHICLE"
                          }, {
                              hash = 2518351607,
                              name = "Rumpo",
                              type = "VEHICLE"
                          }, {
                              hash = 1475773103,
                              name = "Rumpo Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 3484649228,
                              name = "Speedo",
                              type = "VEHICLE"
                          }, {
                              hash = 728614474,
                              name = "Clown Van",
                              type = "VEHICLE"
                          }, {
                              hash = 219613597,
                              name = "Speedo Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 699456151,
                              name = "Surfer",
                              type = "VEHICLE"
                          }, {
                              hash = 2983726598,
                              name = "Surfer",
                              type = "VEHICLE"
                          }, {
                              hash = 3259477733,
                              name = "Surfer Custom",
                              type = "VEHICLE"
                          },{
                              hash = 1951180813,
                              name = "Taco Van",
                              type = "VEHICLE"
                          }, {
                              hash = 65402552,
                              name = "Youga",
                              type = "VEHICLE"
                          }, {
                              hash = 1026149675,
                              name = "Youga Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 1802742206,
                              name = "Youga Classic 4x4",
                              type = "VEHICLE"
                          }, {
                              hash = 1486521356,
                              name = "Youga Custom",
                              type = "VEHICLE"
                          } },
                name = "Van"
            }, {
                is_folder = true,
                items = { {
                              hash = 1131912276,
                              name = "BMX",
                              type = "VEHICLE"
                          }, {
                              hash = 448402357,
                              name = "Cruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 3458454463,
                              name = "Fixter",
                              type = "VEHICLE"
                          }, {
                              hash = 4108429845,
                              name = "Scorcher",
                              type = "VEHICLE"
                          }, {
                              hash = 1127861609,
                              name = "Whippet Race Bike",
                              type = "VEHICLE"
                          }, {
                              hash = 3061159916,
                              name = "Endurex Race Bike",
                              type = "VEHICLE"
                          }, {
                              hash = 3894672200,
                              name = "Tri-Cycles Race Bike",
                              type = "VEHICLE"
                          } },
                name = "Cycle"
            }, {
                is_folder = true,
                items = { {
                              hash = 2588363614,
                              name = "Avisa",
                              type = "VEHICLE"
                          }, {
                              hash = 1033245328,
                              name = "Dinghy",
                              type = "VEHICLE"
                          }, {
                              hash = 276773164,
                              name = "Dinghy",
                              type = "VEHICLE"
                          }, {
                              hash = 509498602,
                              name = "Dinghy",
                              type = "VEHICLE"
                          }, {
                              hash = 867467158,
                              name = "Dinghy",
                              type = "VEHICLE"
                          }, {
                              hash = 3314393930,
                              name = "Weaponized Dinghy",
                              type = "VEHICLE"
                          }, {
                              hash = 861409633,
                              name = "Jetmax",
                              type = "VEHICLE"
                          }, {
                              hash = 1336872304,
                              name = "Kosatka",
                              type = "VEHICLE"
                          }, {
                              hash = 1861786828,
                              name = "Longfin",
                              type = "VEHICLE"
                          }, {
                              hash = 3251507587,
                              name = "Marquis",
                              type = "VEHICLE"
                          }, {
                              hash = 4018222598,
                              name = "Kurtz 31 Patrol Boat",
                              type = "VEHICLE"
                          }, {
                              hash = 3806844075,
                              name = "Police Predator",
                              type = "VEHICLE"
                          }, {
                              hash = 3264692260,
                              name = "Seashark",
                              type = "VEHICLE"
                          }, {
                              hash = 3678636260,
                              name = "Seashark",
                              type = "VEHICLE"
                          }, {
                              hash = 3983945033,
                              name = "Seashark",
                              type = "VEHICLE"
                          }, {
                              hash = 231083307,
                              name = "Speeder",
                              type = "VEHICLE"
                          }, {
                              hash = 437538602,
                              name = "Speeder",
                              type = "VEHICLE"
                          }, {
                              hash = 400514754,
                              name = "Squalo",
                              type = "VEHICLE"
                          }, {
                              hash = 771711535,
                              name = "Submersible",
                              type = "VEHICLE"
                          }, {
                              hash = 3228633070,
                              name = "Kraken",
                              type = "VEHICLE"
                          }, {
                              hash = 4012021193,
                              name = "Suntrap",
                              type = "VEHICLE"
                          }, {
                              hash = 1070967343,
                              name = "Toro",
                              type = "VEHICLE"
                          }, {
                              hash = 908897389,
                              name = "Toro",
                              type = "VEHICLE"
                          }, {
                              hash = 290013743,
                              name = "Tropic",
                              type = "VEHICLE"
                          }, {
                              hash = 1448677353,
                              name = "Tropic",
                              type = "VEHICLE"
                          }, {
                              hash = 2194326579,
                              name = "Tug",
                              type = "VEHICLE"
                          } },
                name = "Boat"
            }, {
                is_folder = true,
                items = { {
                              hash = 1181327175,
                              name = "Akula",
                              type = "VEHICLE"
                          }, {
                              hash = 837858166,
                              name = "Annihilator",
                              type = "VEHICLE"
                          }, {
                              hash = 295054921,
                              name = "Annihilator Stealth",
                              type = "VEHICLE"
                          }, {
                              hash = 788747387,
                              name = "Buzzard Attack Chopper",
                              type = "VEHICLE"
                          }, {
                              hash = 745926877,
                              name = "Buzzard",
                              type = "VEHICLE"
                          }, {
                              hash = 4244420235,
                              name = "Cargobob",
                              type = "VEHICLE"
                          }, {
                              hash = 1621617168,
                              name = "Cargobob",
                              type = "VEHICLE"
                          }, {
                              hash = 1394036463,
                              name = "Cargobob",
                              type = "VEHICLE"
                          }, {
                              hash = 2025593404,
                              name = "Cargobob",
                              type = "VEHICLE"
                          }, {
                              hash = 3817135397,
                              name = "Conada",
                              type = "VEHICLE"
                          }, {
                              hash = 744705981,
                              name = "Frogger",
                              type = "VEHICLE"
                          }, {
                              hash = 1949211328,
                              name = "Frogger",
                              type = "VEHICLE"
                          }, {
                              hash = 2310691317,
                              name = "Havok",
                              type = "VEHICLE"
                          }, {
                              hash = 4252008158,
                              name = "FH-1 Hunter",
                              type = "VEHICLE"
                          }, {
                              hash = 2634305738,
                              name = "Maverick",
                              type = "VEHICLE"
                          }, {
                              hash = 353883353,
                              name = "Police Maverick",
                              type = "VEHICLE"
                          }, {
                              hash = 4212341271,
                              name = "Savage",
                              type = "VEHICLE"
                          }, {
                              hash = 3568198617,
                              name = "Sea Sparrow",
                              type = "VEHICLE"
                          }, {
                              hash = 1229411063,
                              name = "Sparrow",
                              type = "VEHICLE"
                          }, {
                              hash = 1593933419,
                              name = "Sparrow",
                              type = "VEHICLE"
                          }, {
                              hash = 1044954915,
                              name = "Skylift",
                              type = "VEHICLE"
                          }, {
                              hash = 710198397,
                              name = "SuperVolito",
                              type = "VEHICLE"
                          }, {
                              hash = 2623428164,
                              name = "SuperVolito Carbon",
                              type = "VEHICLE"
                          }, {
                              hash = 3955379698,
                              name = "Swift",
                              type = "VEHICLE"
                          }, {
                              hash = 1075432268,
                              name = "Swift Deluxe",
                              type = "VEHICLE"
                          }, {
                              hash = 2694714877,
                              name = "Valkyrie",
                              type = "VEHICLE"
                          }, {
                              hash = 1543134283,
                              name = "Valkyrie MOD.0",
                              type = "VEHICLE"
                          }, {
                              hash = 2449479409,
                              name = "Volatus",
                              type = "VEHICLE"
                          } },
                name = "Helicopter"
            }, {
                is_folder = true,
                items = { {
                              hash = 3929093893,
                              name = "RO-86 Alkonost",
                              type = "VEHICLE"
                          }, {
                              hash = 2771347558,
                              name = "Alpha-Z1",
                              type = "VEHICLE"
                          }, {
                              hash = 2176659152,
                              name = "Avenger",
                              type = "VEHICLE"
                          }, {
                              hash = 408970549,
                              name = "Avenger",
                              type = "VEHICLE"
                          }, {
                              hash = 1824333165,
                              name = "Besra",
                              type = "VEHICLE"
                          }, {
                              hash = 4143991942,
                              name = "Atomic Blimp",
                              type = "VEHICLE"
                          }, {
                              hash = 3681241380,
                              name = "Xero Blimp",
                              type = "VEHICLE"
                          }, {
                              hash = 3987008919,
                              name = "Blimp",
                              type = "VEHICLE"
                          }, {
                              hash = 4262088844,
                              name = "RM-10 Bombushka",
                              type = "VEHICLE"
                          }, {
                              hash = 368211810,
                              name = "Cargo Plane",
                              type = "VEHICLE"
                          },{
                              hash = 2336777441,
                              name = "Cargo Plane 2",
                              type = "VEHICLE"
                          }, {
                              hash = 3650256867,
                              name = "Cuban 800",
                              type = "VEHICLE"
                          }, {
                              hash = 3393804037,
                              name = "Dodo",
                              type = "VEHICLE"
                          }, {
                              hash = 970356638,
                              name = "Duster",
                              type = "VEHICLE"
                          }, {
                              hash = 3287439187,
                              name = "Howard NX-25",
                              type = "VEHICLE"
                          }, {
                              hash = 970385471,
                              name = "Hydra",
                              type = "VEHICLE"
                          }, {
                              hash = 1058115860,
                              name = "Jet",
                              type = "VEHICLE"
                          }, {
                              hash = 3013282534,
                              name = "P-996 LAZER",
                              type = "VEHICLE"
                          }, {
                              hash = 621481054,
                              name = "Luxor",
                              type = "VEHICLE"
                          }, {
                              hash = 3080673438,
                              name = "Luxor Deluxe",
                              type = "VEHICLE"
                          }, {
                              hash = 2548391185,
                              name = "Mammatus",
                              type = "VEHICLE"
                          }, {
                              hash = 2531412055,
                              name = "Ultralight",
                              type = "VEHICLE"
                          }, {
                              hash = 165154707,
                              name = "Miljet",
                              type = "VEHICLE"
                          }, {
                              hash = 3545667823,
                              name = "Mogul",
                              type = "VEHICLE"
                          }, {
                              hash = 1565978651,
                              name = "V-65 Molotok",
                              type = "VEHICLE"
                          }, {
                              hash = 2999939664,
                              name = "Nimbus",
                              type = "VEHICLE"
                          }, {
                              hash = 1036591958,
                              name = "P-45 Nokota",
                              type = "VEHICLE"
                          }, {
                              hash = 2908775872,
                              name = "Pyro",
                              type = "VEHICLE"
                          }, {
                              hash = 3319621991,
                              name = "Rogue",
                              type = "VEHICLE"
                          }, {
                              hash = 3902291871,
                              name = "Seabreeze",
                              type = "VEHICLE"
                          }, {
                              hash = 3080461301,
                              name = "Shamal",
                              type = "VEHICLE"
                          }, {
                              hash = 2594093022,
                              name = "LF-22 Starling",
                              type = "VEHICLE"
                          }, {
                              hash = 1692272545,
                              name = "B-11 Strikeforce",
                              type = "VEHICLE"
                          }, {
                              hash = 2172210288,
                              name = "Mallard",
                              type = "VEHICLE"
                          }, {
                              hash = 1981688531,
                              name = "Titan",
                              type = "VEHICLE"
                          }, {
                              hash = 1043222410,
                              name = "Tula",
                              type = "VEHICLE"
                          }, {
                              hash = 2621610858,
                              name = "Velum",
                              type = "VEHICLE"
                          }, {
                              hash = 1077420264,
                              name = "Velum 5-Seater",
                              type = "VEHICLE"
                          }, {
                              hash = 1341619767,
                              name = "Vestra",
                              type = "VEHICLE"
                          }, {
                              hash = 447548909,
                              name = "Volatol",
                              type = "VEHICLE"
                          } },
                name = "Plane"
            }, {
                is_folder = true,
                items = { {
                              hash = 1118611807,
                              name = "Asbo",
                              type = "VEHICLE"
                          }, {
                              hash = 3950024287,
                              name = "Blista",
                              type = "VEHICLE"
                          }, {
                              hash = 1549126457,
                              name = "Brioso R/A",
                              type = "VEHICLE"
                          }, {
                              hash = 1429622905,
                              name = "Brioso 300",
                              type = "VEHICLE"
                          }, {
                              hash = 15214558,
                              name = "Brioso 300 Widebody",
                              type = "VEHICLE"
                          }, {
                              hash = 2196012677,
                              name = "Club",
                              type = "VEHICLE"
                          }, {
                              hash = 3164157193,
                              name = "Dilettante",
                              type = "VEHICLE"
                          }, {
                              hash = 1682114128,
                              name = "Dilettante",
                              type = "VEHICLE"
                          }, {
                              hash = 3117103977,
                              name = "Issi",
                              type = "VEHICLE"
                          }, {
                              hash = 931280609,
                              name = "Issi Classic",
                              type = "VEHICLE"
                          }, {
                              hash = 628003514,
                              name = "Apocalypse Issi",
                              type = "VEHICLE"
                          }, {
                              hash = 1537277726,
                              name = "Future Shock Issi",
                              type = "VEHICLE"
                          }, {
                              hash = 1239571361,
                              name = "Nightmare Issi",
                              type = "VEHICLE"
                          }, {
                              hash = 409049982,
                              name = "Blista Kanjo",
                              type = "VEHICLE"
                          }, {
                              hash = 3863274624,
                              name = "Panto",
                              type = "VEHICLE"
                          }, {
                              hash = 2844316578,
                              name = "Prairie",
                              type = "VEHICLE"
                          }, {
                              hash = 841808271,
                              name = "Rhapsody",
                              type = "VEHICLE"
                          }, {
                              hash = 1644055914,
                              name = "Weevil",
                              type = "VEHICLE"
                          } },
                name = "Compact"
            }, {
                is_folder = true,
                items = { {
                              hash = 340154634,
                              name = "PR4",
                              type = "VEHICLE"
                          }, {
                              hash = 2334210311,
                              name = "R88",
                              type = "VEHICLE"
                          }, {
                              hash = 1492612435,
                              name = "BR8",
                              type = "VEHICLE"
                          }, {
                              hash = 1181339704,
                              name = "DR1",
                              type = "VEHICLE"
                          } },
                name = "Open Wheel"
            }, {
                is_folder = true,
                items = {
                    {
                        hash = 1283517198,
                        name = "Airport Bus",
                        type = "VEHICLE"
                    }, {
                        hash = 3989239879,
                        name = "Brickade",
                        type = "VEHICLE"
                    },{
                        hash = 2718380883,
                        name = "Brickade 6x6",
                        type = "VEHICLE"
                    },{
                        hash = 3581397346,
                        name = "Bus",
                        type = "VEHICLE"
                    }, {
                        hash = 2222034228,
                        name = "Dashound",
                        type = "VEHICLE"
                    }, {
                        hash = 345756458,
                        name = "Festival Bus",
                        type = "VEHICLE"
                    }, {
                        hash = 2191146052,
                        name = "Dune",
                        type = "VEHICLE"
                    }, {
                        hash = 3196165219,
                        name = "Rental Shuttle Bus",
                        type = "VEHICLE"
                    }, {
                        hash = 3338918751,
                        name = "Taxi",
                        type = "VEHICLE"
                    }, {
                        hash = 1941029835,
                        name = "Tourbus",
                        type = "VEHICLE"
                    }, {
                        hash = 1917016601,
                        name = "Trashmaster",
                        type = "VEHICLE"
                    }, {
                        hash = 3039269212,
                        name = "Trashmaster",
                        type = "VEHICLE"
                    }, {
                        hash = 2382949506,
                        name = "Wastelander",
                        type = "VEHICLE"
                    }
                },
                name = "Service"
            }, {
                is_folder = true,
                items = { {
                              hash = 1171614426,
                              name = "Ambulance",
                              type = "VEHICLE"
                          }, {
                              hash = 1127131465,
                              name = "FIB",
                              type = "VEHICLE"
                          }, {
                              hash = 2647026068,
                              name = "FIB",
                              type = "VEHICLE"
                          }, {
                              hash = 1938952078,
                              name = "Fire Truck",
                              type = "VEHICLE"
                          }, {
                              hash = 469291905,
                              name = "Lifeguard",
                              type = "VEHICLE"
                          }, {
                              hash = 2287941233,
                              name = "Police Prison Bus",
                              type = "VEHICLE"
                          }, {
                              hash = 2046537925,
                              name = "Police Cruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 2667966721,
                              name = "Police Cruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 1912215274,
                              name = "Police Cruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 2321795001,
                              name = "Unmarked Cruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 4260343491,
                              name = "Police Bike",
                              type = "VEHICLE"
                          }, {
                              hash = 2758042359,
                              name = "Police Rancher",
                              type = "VEHICLE"
                          }, {
                              hash = 2515846680,
                              name = "Police Roadcruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 456714581,
                              name = "Police Transporter",
                              type = "VEHICLE"
                          }, {
                              hash = 741586030,
                              name = "Park Ranger",
                              type = "VEHICLE"
                          }, {
                              hash = 3089277354,
                              name = "Police Riot",
                              type = "VEHICLE"
                          }, {
                              hash = 2601952180,
                              name = "RCV",
                              type = "VEHICLE"
                          }, {
                              hash = 2611638396,
                              name = "Sheriff Cruiser",
                              type = "VEHICLE"
                          }, {
                              hash = 1922257928,
                              name = "Sheriff SUV",
                              type = "VEHICLE"
                          } },
                name = "Emergency"
            }, {
                is_folder = true,
                items = { {
                              hash = 562680400,
                              name = "APC",
                              type = "VEHICLE"
                          }, {
                              hash = 3471458123,
                              name = "Barracks",
                              type = "VEHICLE"
                          }, {
                              hash = 1074326203,
                              name = "Barracks Semi",
                              type = "VEHICLE"
                          }, {
                              hash = 630371791,
                              name = "Barracks",
                              type = "VEHICLE"
                          }, {
                              hash = 4081974053,
                              name = "Barrage",
                              type = "VEHICLE"
                          }, {
                              hash = 3602674979,
                              name = "Chernobog",
                              type = "VEHICLE"
                          }, {
                              hash = 321739290,
                              name = "Crusader",
                              type = "VEHICLE"
                          }, {
                              hash = 4262731174,
                              name = "Half-track",
                              type = "VEHICLE"
                          }, {
                              hash = 2859440138,
                              name = "TM-02 Khanjali",
                              type = "VEHICLE"
                          }, {
                              hash = 3040635986,
                              name = "Invade and Persuade Tank",
                              type = "VEHICLE"
                          }, {
                              hash = 782665360,
                              name = "Rhino Tank",
                              type = "VEHICLE"
                          }, {
                              hash = 3147997943,
                              name = "Apocalypse Scarab",
                              type = "VEHICLE"
                          }, {
                              hash = 1542143200,
                              name = "Future Shock Scarab",
                              type = "VEHICLE"
                          }, {
                              hash = 3715219435,
                              name = "Nightmare Scarab",
                              type = "VEHICLE"
                          }, {
                              hash = 1489874736,
                              name = "Thruster",
                              type = "VEHICLE"
                          }, {
                              hash = 2413121211,
                              name = "Anti-Aircraft Trailer",
                              type = "VEHICLE"
                          }, {
                              hash = 2014313426,
                              name = "Vetir",
                              type = "VEHICLE"
                          } },
                name = "Military"
            }, {
                is_folder = true,
                items = { {
                              hash = 2053223216,
                              name = "Benson",
                              type = "VEHICLE"
                          }, {
                              hash = 850991848,
                              name = "Biff",
                              type = "VEHICLE"
                          }, {
                              hash = 3493417227,
                              name = "Apocalypse Cerberus",
                              type = "VEHICLE"
                          }, {
                              hash = 679453769,
                              name = "Future Shock Cerberus",
                              type = "VEHICLE"
                          }, {
                              hash = 1909700336,
                              name = "Nightmare Cerberus",
                              type = "VEHICLE"
                          }, {
                              hash = 1518533038,
                              name = "Hauler",
                              type = "VEHICLE"
                          }, {
                              hash = 387748548,
                              name = "Hauler Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 904750859,
                              name = "Mule",
                              type = "VEHICLE"
                          }, {
                              hash = 3244501995,
                              name = "Mule",
                              type = "VEHICLE"
                          }, {
                              hash = 2242229361,
                              name = "Mule",
                              type = "VEHICLE"
                          }, {
                              hash = 1945374990,
                              name = "Mule Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1343932732,
                              name = "Mule",
                              type = "VEHICLE"
                          }, {
                              hash = 569305213,
                              name = "Packer",
                              type = "VEHICLE"
                          }, {
                              hash = 2157618379,
                              name = "Phantom",
                              type = "VEHICLE"
                          }, {
                              hash = 2645431192,
                              name = "Phantom Wedge",
                              type = "VEHICLE"
                          }, {
                              hash = 177270108,
                              name = "Phantom Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 2112052861,
                              name = "Pounder",
                              type = "VEHICLE"
                          }, {
                              hash = 1653666139,
                              name = "Pounder Custom",
                              type = "VEHICLE"
                          }, {
                              hash = 1747439474,
                              name = "Stockade",
                              type = "VEHICLE"
                          }, {
                              hash = 4080511798,
                              name = "Stockade",
                              type = "VEHICLE"
                          }, {
                              hash = 2306538597,
                              name = "Terrorbyte",
                              type = "VEHICLE"
                          } },
                name = "Commercial"
            }, {
                is_folder = true,
                items = { {
                              hash = 3334677549,
                              name = "Cable Car",
                              type = "VEHICLE"
                          }, {
                              hash = 1030400667,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 184361638,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 3186376089,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 920453016,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 240201337,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 642617954,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 868868440,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }, {
                              hash = 586013744,
                              name = "Freight Train",
                              type = "VEHICLE"
                          }
                },
                name = "Rail"
            },
        },
    },
    {
        name = "Peds",
        is_folder = true,
        items = {
            {
                name = "Ambient Females",
                is_folder = true,
                items = {
                    {
                        name = "Beach Bikini",
                        model = "a_f_m_beach_01",
                        type = "PED",
                    },
                    {
                        name = "Beverly Hills 1",
                        model = "a_f_m_bevhills_01",
                        type = "PED",
                    },
                    {
                        name = "Beverly Hills 2",
                        model = "a_f_m_bevhills_02",
                        type = "PED",
                    },
                    {
                        name = "Bodybuilder",
                        model = "a_f_m_bodybuild_01",
                        type = "PED",
                    },
                    {
                        name = "Business",
                        model = "a_f_m_business_02",
                        type = "PED",
                    },
                    {
                        name = "Downtown 1",
                        model = "a_f_m_downtown_01",
                        type = "PED",
                    },
                    {
                        name = "East SA",
                        model = "a_f_m_eastsa_01",
                        type = "PED",
                    },
                    {
                        name = "East SA 2",
                        model = "a_f_m_eastsa_02",
                        type = "PED",
                    },
                    {
                        name = "Fat Black 1",
                        model = "a_f_m_fatbla_01",
                        type = "PED",
                    },
                    {
                        name = "Fat Cult",
                        model = "a_f_m_fatcult_01",
                        type = "PED",
                    },
                    {
                        name = "Fat White",
                        model = "a_f_m_fatwhite_01",
                        type = "PED",
                    },
                    {
                        name = "General Street",
                        model = "A_F_M_GenStreet_01",
                        type = "PED",
                    },
                    {
                        name = "K town 1",
                        model = "a_f_m_ktown_01",
                        type = "PED",
                    },
                    {
                        name = "K town 2",
                        model = "a_f_m_ktown_02",
                        type = "PED",
                    },
                    {
                        name = "Prologue Hostage",
                        model = "a_f_m_prolhost_01",
                        type = "PED",
                    },
                    {
                        name = "Salton",
                        model = "a_f_m_salton_01",
                        type = "PED",
                    },
                    {
                        name = "Skidrow",
                        model = "a_f_m_skidrow_01",
                        type = "PED",
                    },
                    {
                        name = "South Central",
                        model = "a_f_m_soucent_01",
                        type = "PED",
                    },
                    {
                        name = "South Central 2",
                        model = "a_f_m_soucent_02",
                        type = "PED",
                    },
                    {
                        name = "South Central MC",
                        model = "a_f_m_soucentmc_01",
                        type = "PED",
                    },
                    {
                        name = "Tourist",
                        model = "a_f_m_tourist_01",
                        type = "PED",
                    },
                    {
                        name = "Tramp",
                        model = "a_f_m_tramp_01",
                        type = "PED",
                    },
                    {
                        name = "Tramp Beach",
                        model = "a_f_m_trampbeac_01",
                        type = "PED",
                    },
                    {
                        name = "Older General Street Female",
                        model = "a_f_o_genstreet_01",
                        type = "PED",
                    },
                    {
                        name = "Older Indian",
                        model = "a_f_o_indian_01",
                        type = "PED",
                    },
                    {
                        name = "Older Ktown",
                        model = "a_f_o_ktown_01",
                        type = "PED",
                    },
                    {
                        name = "Older Salton",
                        model = "a_f_o_salton_01",
                        type = "PED",
                    },
                    {
                        name = "Older South Central 1",
                        model = "a_f_o_soucent_01",
                        type = "PED",
                    },
                    {
                        name = "Older South Central 2",
                        model = "a_f_o_soucent_02",
                        type = "PED",
                    },
                    {
                        name = "Young Beach",
                        model = "a_f_y_beach_01",
                        type = "PED",
                    },
                    {
                        name = "Young Beverly Hills 1",
                        model = "a_f_y_bevhills_01",
                        type = "PED",
                    },
                    {
                        name = "Young Beverly Hills 2",
                        model = "a_f_y_bevhills_02",
                        type = "PED",
                    },
                    {
                        name = "Young Beverly Hills 3",
                        model = "a_f_y_bevhills_03",
                        type = "PED",
                    },
                    {
                        name = "Young Beverly Hills 4",
                        model = "a_f_y_bevhills_04",
                        type = "PED",
                    },
                    {
                        name = "Young Business 1",
                        model = "a_f_y_business_01",
                        type = "PED",
                    },
                    {
                        name = "Young Business 2",
                        model = "a_f_y_business_02",
                        type = "PED",
                    },
                    {
                        name = "Young Business 3",
                        model = "a_f_y_business_03",
                        type = "PED",
                    },
                    {
                        name = "Young Business 4",
                        model = "a_f_y_business_04",
                        type = "PED",
                    },
                    {
                        name = "Young East SA 1",
                        model = "a_f_y_eastsa_01",
                        type = "PED",
                    },
                    {
                        name = "Young East SA 2",
                        model = "a_f_y_eastsa_02",
                        type = "PED",
                    },
                    {
                        name = "Young East SA 3",
                        model = "a_f_y_eastsa_03",
                        type = "PED",
                    },
                    {
                        name = "Young Epsilon",
                        model = "a_f_y_epsilon_01",
                        type = "PED",
                    },
                    {
                        name = "Young Agent",
                        model = "a_f_y_femaleagent",
                        type = "PED",
                    },
                    {
                        name = "Young Fitness 1",
                        model = "a_f_y_fitness_01",
                        type = "PED",
                    },
                    {
                        name = "Young Fitness 2",
                        model = "a_f_y_fitness_02",
                        type = "PED",
                    },
                    {
                        name = "General Female",
                        model = "a_f_y_genhot_01",
                        type = "PED",
                    },
                    {
                        name = "Golfer",
                        model = "a_f_y_golfer_01",
                        type = "PED",
                    },
                    {
                        name = "Hiker",
                        model = "a_f_y_hiker_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hippe",
                        model = "a_f_y_hippie_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 1",
                        model = "a_f_y_hipster_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 2",
                        model = "a_f_y_hipster_02",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 3",
                        model = "a_f_y_hipster_03",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 4",
                        model = "a_f_y_hipster_04",
                        type = "PED",
                    },
                    {
                        name = "Young Indian",
                        model = "a_f_y_indian_01",
                        type = "PED",
                    },
                    {
                        name = "Young Juggalo",
                        model = "a_f_y_juggalo_01",
                        type = "PED",
                    },
                    {
                        name = "Runner",
                        model = "a_f_y_runner_01",
                        type = "PED",
                    },
                    {
                        name = "Rural Meth",
                        model = "a_f_y_rurmeth_01",
                        type = "PED",
                    },
                    {
                        name = "Dressy",
                        model = "a_f_y_scdressy_01",
                        type = "PED",
                    },
                    {
                        name = "Skater",
                        model = "a_f_y_skater_01",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 1",
                        model = "a_f_y_soucent_01",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 2",
                        model = "a_f_y_soucent_02",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 3",
                        model = "a_f_y_soucent_03",
                        type = "PED",
                    },
                    {
                        name = "Tennis Player",
                        model = "a_f_y_tennis_01",
                        type = "PED",
                    },
                    {
                        name = "Topless",
                        model = "a_f_y_topless_01",
                        type = "PED",
                    },
                    {
                        name = "Young  Tourist 1",
                        model = "a_f_y_tourist_01",
                        type = "PED",
                    },
                    {
                        name = "Young  Tourist 2",
                        model = "a_f_y_tourist_02",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 1",
                        model = "a_f_y_vinewood_01",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 2",
                        model = "a_f_y_vinewood_02",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 3",
                        model = "a_f_y_vinewood_03",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 4",
                        model = "a_f_y_vinewood_04",
                        type = "PED",
                    },
                    {
                        name = "Yoga",
                        model = "a_f_y_yoga_01",
                        type = "PED",
                    },
                },
            },
            {
                name = "Ambient Males",
                is_folder = true,
                items = {
                    {
                        name = "Naked Altruist Cult",
                        model = "a_m_m_acult_01",
                        type = "PED",
                    },
                    {
                        name = "African American",
                        model = "a_m_m_afriamer_01",
                        type = "PED",
                    },
                    {
                        name = "Bank Robber",
                        model = "A_M_M_BankRobber_01",
                        type = "PED",
                    },
                    {
                        name = "Beach 1",
                        model = "a_m_m_beach_01",
                        type = "PED",
                    },
                    {
                        name = "Beach 2",
                        model = "a_m_m_beach_02",
                        type = "PED",
                    },
                    {
                        name = "Beverly hills 1",
                        model = "a_m_m_bevhills_01",
                        type = "PED",
                    },
                    {
                        name = "Beverly hills 2",
                        model = "a_m_m_bevhills_02",
                        type = "PED",
                    },
                    {
                        name = "Business 1",
                        model = "a_m_m_business_01",
                        type = "PED",
                    },
                    {
                        name = "East SA 1",
                        model = "a_m_m_eastsa_01",
                        type = "PED",
                    },
                    {
                        name = "East SA 2",
                        model = "a_m_m_eastsa_02",
                        type = "PED",
                    },
                    {
                        name = "Farmer",
                        model = "a_m_m_farmer_01",
                        type = "PED",
                    },
                    {
                        name = "Fat Latino",
                        model = "a_m_m_fatlatin_01",
                        type = "PED",
                    },
                    {
                        name = "Generic Fat 1",
                        model = "a_m_m_genfat_01",
                        type = "PED",
                    },
                    {
                        name = "Generic Fat 2",
                        model = "a_m_m_genfat_02",
                        type = "PED",
                    },
                    {
                        name = "Golfer",
                        model = "a_m_m_golfer_01",
                        type = "PED",
                    },
                    {
                        name = "Rabbi",
                        model = "a_m_m_hasjew_01",
                        type = "PED",
                    },
                    {
                        name = "Hillbilly 1",
                        model = "a_m_m_hillbilly_01",
                        type = "PED",
                    },
                    {
                        name = "Hillbilly 2",
                        model = "a_m_m_hillbilly_02",
                        type = "PED",
                    },
                    {
                        name = "Indian",
                        model = "a_m_m_indian_01",
                        type = "PED",
                    },
                    {
                        name = "Ktown 1",
                        model = "a_m_m_ktown_01",
                        type = "PED",
                    },
                    {
                        name = "Malibu 1",
                        model = "a_m_m_malibu_01",
                        type = "PED",
                    },
                    {
                        name = "Mexican Country",
                        model = "a_m_m_mexcntry_01",
                        type = "PED",
                    },
                    {
                        name = "Mexican Laborer",
                        model = "a_m_m_mexlabor_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_m_og_boss_01",
                        model = "a_m_m_og_boss_01",
                        type = "PED",
                    },
                    {
                        name = "Paparazzi",
                        model = "a_m_m_paparazzi_01",
                        type = "PED",
                    },
                    {
                        name = "Polynesian",
                        model = "a_m_m_polynesian_01",
                        type = "PED",
                    },
                    {
                        name = "Prologue Hostage",
                        model = "a_m_m_prolhost_01",
                        type = "PED",
                    },
                    {
                        name = "Rural Meth Head",
                        model = "a_m_m_rurmeth_01",
                        type = "PED",
                    },
                    {
                        name = "Salton 1",
                        model = "a_m_m_salton_01",
                        type = "PED",
                    },
                    {
                        name = "Salton 2",
                        model = "a_m_m_salton_02",
                        type = "PED",
                    },
                    {
                        name = "Salton 3",
                        model = "a_m_m_salton_03",
                        type = "PED",
                    },
                    {
                        name = "Salton 4",
                        model = "a_m_m_salton_04",
                        type = "PED",
                    },
                    {
                        name = "Skater",
                        model = "a_m_m_skater_01",
                        type = "PED",
                    },
                    {
                        name = "Skidrow",
                        model = "a_f_m_skidrow_01",
                        type = "PED",
                    },
                    {
                        name = "South Central Latino",
                        model = "a_m_m_socenlat_01",
                        type = "PED",
                    },
                    {
                        name = "South Central 1",
                        model = "a_m_m_soucent_01",
                        type = "PED",
                    },
                    {
                        name = "South Central 2",
                        model = "a_m_m_soucent_02",
                        type = "PED",
                    },
                    {
                        name = "South Central 3",
                        model = "a_m_m_soucent_03",
                        type = "PED",
                    },
                    {
                        name = "South Central 4",
                        model = "a_m_m_soucent_04",
                        type = "PED",
                    },
                    {
                        name = "Latino 2",
                        model = "a_m_m_stlat_02",
                        type = "PED",
                    },
                    {
                        name = "Tennis",
                        model = "a_m_m_tennis_01",
                        type = "PED",
                    },
                    {
                        name = "Tourist",
                        model = "a_m_m_tourist_01",
                        type = "PED",
                    },
                    {
                        name = "Tramp",
                        model = "a_m_m_tramp_01",
                        type = "PED",
                    },
                    {
                        name = "Tramp Beach",
                        model = "a_m_m_trampbeac_01",
                        type = "PED",
                    },
                    {
                        name = "Tranvest",
                        model = "a_m_m_tranvest_01",
                        type = "PED",
                    },
                    {
                        name = "Tranvest 2",
                        model = "a_m_m_tranvest_02",
                        type = "PED",
                    },
                    {
                        name = "Old Altruist Cult 1",
                        model = "a_m_o_acult_01",
                        type = "PED",
                    },
                    {
                        name = "Old Altruist Cult 2",
                        model = "a_m_o_acult_02",
                        type = "PED",
                    },
                    {
                        name = "Old Beach",
                        model = "a_m_o_beach_01",
                        type = "PED",
                    },
                    {
                        name = "Old Generic Street",
                        model = "a_m_o_genstreet_01",
                        type = "PED",
                    },
                    {
                        name = "Old Ktown",
                        model = "a_m_o_ktown_01",
                        type = "PED",
                    },
                    {
                        name = "Old Salton",
                        model = "a_m_o_salton_01",
                        type = "PED",
                    },
                    {
                        name = "Old South Central 1",
                        model = "a_m_o_soucent_01",
                        type = "PED",
                    },
                    {
                        name = "Old South Central 2",
                        model = "a_m_o_soucent_02",
                        type = "PED",
                    },
                    {
                        name = "Old South Central 3",
                        model = "a_m_o_soucent_03",
                        type = "PED",
                    },
                    {
                        name = "Old Tramp 1",
                        model = "a_m_o_tramp_01",
                        type = "PED",
                    },
                    {
                        name = "Young Altruist Cult 1",
                        model = "a_m_y_acult_01",
                        type = "PED",
                    },
                    {
                        name = "Young Altruist Cult 2",
                        model = "a_m_y_acult_02",
                        type = "PED",
                    },
                    {
                        name = "Young Beach 1",
                        model = "a_m_y_beach_01",
                        type = "PED",
                    },
                    {
                        name = "Young Beach 2",
                        model = "a_m_y_beach_02",
                        type = "PED",
                    },
                    {
                        name = "Young Beach 3",
                        model = "a_m_y_beach_03",
                        type = "PED",
                    },
                    {
                        name = "Young Beach Vesp 1",
                        model = "a_m_y_beachvesp_01",
                        type = "PED",
                    },
                    {
                        name = "Young Beach Vesp 2",
                        model = "a_m_y_beachvesp_02",
                        type = "PED",
                    },
                    {
                        name = "Young Beverly Hills 1",
                        model = "a_m_y_bevhills_01",
                        type = "PED",
                    },
                    {
                        name = "Young Beverly Hills 2",
                        model = "a_m_y_bevhills_02",
                        type = "PED",
                    },
                    {
                        name = "Breakdance",
                        model = "a_m_y_breakdance_01",
                        type = "PED",
                    },
                    {
                        name = "Young Business",
                        model = "a_m_y_busicas_01",
                        type = "PED",
                    },
                    {
                        name = "Young Business 1",
                        model = "a_m_y_business_01",
                        type = "PED",
                    },
                    {
                        name = "Young Business 2",
                        model = "a_m_y_business_02",
                        type = "PED",
                    },
                    {
                        name = "Young Business 3",
                        model = "a_m_y_business_03",
                        type = "PED",
                    },
                    {
                        name = "Cyclist",
                        model = "a_m_y_cyclist_01",
                        type = "PED",
                    },
                    {
                        name = "Cyclist 2",
                        model = "a_m_y_dhill_01",
                        type = "PED",
                    },
                    {
                        name = "Young Downtown",
                        model = "a_m_y_downtown_01",
                        type = "PED",
                    },
                    {
                        name = "Young East SA 1",
                        model = "a_m_y_eastsa_01",
                        type = "PED",
                    },
                    {
                        name = "Young East SA 2",
                        model = "a_m_y_eastsa_02",
                        type = "PED",
                    },
                    {
                        name = "Young Epsilon 1",
                        model = "a_m_y_epsilon_01",
                        type = "PED",
                    },
                    {
                        name = "Young Epsilon 2",
                        model = "a_m_y_epsilon_02",
                        type = "PED",
                    },
                    {
                        name = "Gay 1",
                        model = "a_m_y_gay_01",
                        type = "PED",
                    },
                    {
                        name = "Gay 2",
                        model = "a_m_y_gay_02",
                        type = "PED",
                    },
                    {
                        name = "Young Generic Street 1",
                        model = "a_m_y_genstreet_01",
                        type = "PED",
                    },
                    {
                        name = "Young Generic Street 2",
                        model = "a_m_y_genstreet_02",
                        type = "PED",
                    },
                    {
                        name = "Young golfer 1",
                        model = "a_m_y_golfer_01",
                        type = "PED",
                    },
                    {
                        name = "Young Rabbi",
                        model = "a_m_y_hasjew_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hiker",
                        model = "a_m_y_hiker_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hippy",
                        model = "a_m_y_hippy_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 1",
                        model = "a_m_y_hipster_01",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 2",
                        model = "a_m_y_hipster_02",
                        type = "PED",
                    },
                    {
                        name = "Young Hipster 3",
                        model = "a_m_y_hipster_03",
                        type = "PED",
                    },
                    {
                        name = "Young Indian",
                        model = "a_m_y_indian_01",
                        type = "PED",
                    },
                    {
                        name = "Jetski",
                        model = "a_m_y_jetski_01",
                        type = "PED",
                    },
                    {
                        name = "Young juggalo",
                        model = "a_m_y_juggalo_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_ktown_01",
                        model = "a_m_y_ktown_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_ktown_02",
                        model = "a_m_y_ktown_02",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_latino_01",
                        model = "a_m_y_latino_01",
                        type = "PED",
                    },
                    {
                        name = "Young Meth Head",
                        model = "a_m_y_methhead_01",
                        type = "PED",
                    },
                    {
                        name = "Young Mexican",
                        model = "a_m_y_mexthug_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_motox_01",
                        model = "a_m_y_motox_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_motox_02",
                        model = "a_m_y_motox_02",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_musclbeac_01",
                        model = "a_m_y_musclbeac_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_musclbeac_02",
                        model = "a_m_y_musclbeac_02",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_polynesian_01",
                        model = "a_m_y_polynesian_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_roadcyc_01",
                        model = "a_m_y_roadcyc_01",
                        type = "PED",
                    },
                    {
                        name = "Young Runner 1",
                        model = "a_m_y_runner_01",
                        type = "PED",
                    },
                    {
                        name = "Young Runner 2",
                        model = "a_m_y_runner_02",
                        type = "PED",
                    },
                    {
                        name = "Young Salton",
                        model = "a_m_y_salton_01",
                        type = "PED",
                    },
                    {
                        name = "Young Skater 1",
                        model = "a_m_y_skater_01",
                        type = "PED",
                    },
                    {
                        name = "Young Skater 2",
                        model = "a_m_y_skater_02",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 1",
                        model = "a_m_y_soucent_01",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 2",
                        model = "a_m_y_soucent_02",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 3",
                        model = "a_m_y_soucent_03",
                        type = "PED",
                    },
                    {
                        name = "Young South Central 4",
                        model = "a_m_y_soucent_04",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_stbla_01",
                        model = "a_m_y_stbla_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_stlat_01",
                        model = "a_m_y_stlat_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_stwhi_01",
                        model = "a_m_y_stwhi_01",
                        type = "PED",
                    },
                    {
                        name = "a_m_y_stwhi_02",
                        model = "a_m_y_stwhi_02",
                        type = "PED",
                    },
                    {
                        name = "Sunbather",
                        model = "a_m_y_sunbathe_01",
                        type = "PED",
                    },
                    {
                        name = "Surfer",
                        model = "a_m_y_surfer_01",
                        type = "PED",
                    },
                    {
                        name = "Vinewood Douche",
                        model = "a_m_y_vindouche_01",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 1",
                        model = "a_m_y_vinewood_01",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 2",
                        model = "a_m_y_vinewood_02",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 3",
                        model = "a_m_y_vinewood_03",
                        type = "PED",
                    },
                    {
                        name = "Vinewood 4",
                        model = "a_m_y_vinewood_04",
                        type = "PED",
                    },
                    {
                        name = "Yoga",
                        model = "a_m_y_yoga_01",
                        type = "PED",
                    },

                }
            },
            {
                name = "Animals",
                is_folder = true,
                items = {
                    {
                        name = "Boar",
                        model = "a_c_boar",
                        type = "PED",
                    },
                    {
                        name = "Cat",
                        model = "a_c_cat_01",
                        type = "PED",
                    },
                    {
                        name = "Chickenhawk",
                        model = "a_c_chickenhawk",
                        type = "PED",
                    },
                    {
                        name = "Chimp",
                        model = "a_c_chimp",
                        type = "PED",
                    },
                    {
                        name = "Chimp 2",
                        model = "A_C_Chimp_02",
                        type = "PED",
                    },
                    {
                        name = "Chop",
                        model = "a_c_chop",
                        type = "PED",
                    },
                    {
                        name = "Cormorant",
                        model = "a_c_cormorant",
                        type = "PED",
                    },
                    {
                        name = "Cow",
                        model = "a_c_cow",
                        type = "PED",
                    },
                    {
                        name = "Coyote",
                        model = "a_c_coyote",
                        type = "PED",
                    },
                    {
                        name = "Crow",
                        model = "a_c_crow",
                        type = "PED",
                    },
                    {
                        name = "Deer",
                        model = "a_c_deer",
                        type = "PED",
                    },
                    {
                        name = "Dolphin",
                        model = "a_c_dolphin",
                        type = "PED",
                    },
                    {
                        name = "Fish",
                        model = "a_c_fish",
                        type = "PED",
                    },
                    {
                        name = "Hen",
                        model = "a_c_hen",
                        type = "PED",
                    },
                    {
                        name = "Humpback",
                        model = "a_c_humpback",
                        type = "PED",
                    },
                    {
                        name = "Husky",
                        model = "a_c_husky",
                        type = "PED",
                    },
                    {
                        name = "Killer Whale",
                        model = "a_c_killerwhale",
                        type = "PED",
                    },
                    {
                        name = "Mountain Lion",
                        model = "a_c_mtlion",
                        type = "PED",
                    },
                    {
                        name = "Pig",
                        model = "a_c_pig",
                        type = "PED",
                    },
                    {
                        name = "Pigeon",
                        model = "a_c_pigeon",
                        type = "PED",
                    },
                    {
                        name = "Poodle",
                        model = "a_c_poodle",
                        type = "PED",
                    },
                    {
                        name = "Pug",
                        model = "a_c_pug",
                        type = "PED",
                    },
                    {
                        name = "Rabbit",
                        model = "a_c_rabbit_01",
                        type = "PED",
                    },
                    {
                        name = "Rabbit 2",
                        model = "A_C_Rabbit_02",
                        type = "PED",
                    },
                    {
                        name = "Rat",
                        model = "a_c_rat",
                        type = "PED",
                    },
                    {
                        name = "Golden Retriever",
                        model = "a_c_retriever",
                        type = "PED",
                    },
                    {
                        name = "Rhesus Monkey",
                        model = "a_c_rhesus",
                        type = "PED",
                    },
                    {
                        name = "Rottweiler",
                        model = "a_c_rottweiler",
                        type = "PED",
                    },
                    {
                        name = "Seagull",
                        model = "a_c_seagull",
                        type = "PED",
                    },
                    {
                        name = "Hammerhead Shark",
                        model = "a_c_sharkhammer",
                        type = "PED",
                    },
                    {
                        name = "Tiger Shark",
                        model = "a_c_sharktiger",
                        type = "PED",
                    },
                    {
                        name = "English Shephard",
                        model = "a_c_shepherd",
                        type = "PED",
                    },
                    {
                        name = "Stingray",
                        model = "a_c_stingray",
                        type = "PED",
                    },
                    {
                        name = "West Highland Terrier",
                        model = "a_c_westy",
                        type = "PED",
                    },
                },
            },
            {
                name = "Cutscene",
                is_folder = true,
                items = {
                    {
                        name = "Amanda Townley",
                        model = "cs_amandatownley",
                        type = "PED",
                    },
                    {
                        name = "Andreas",
                        model = "cs_andreas",
                        type = "PED",
                    },
                    {
                        name = "Ashley",
                        model = "cs_ashley",
                        type = "PED",
                    },
                    {
                        name = "Bank Manager",
                        model = "cs_bankman",
                        type = "PED",
                    },
                    {
                        name = "Barry",
                        model = "cs_barry",
                        type = "PED",
                    },
                    {
                        name = "Beverly",
                        model = "cs_beverly",
                        type = "PED",
                    },
                    {
                        name = "Brad",
                        model = "cs_brad",
                        type = "PED",
                    },
                    {
                        name = "Brad Cadaver",
                        model = "cs_bradcadaver",
                        type = "PED",
                    },
                    {
                        name = "Car Buyer",
                        model = "cs_carbuyer",
                        type = "PED",
                    },
                    {
                        name = "Casey",
                        model = "cs_casey",
                        type = "PED",
                    },
                    {
                        name = "Cheng SR",
                        model = "cs_chengsr",
                        type = "PED",
                    },
                    {
                        name = "Chris Formage",
                        model = "cs_chrisformage",
                        type = "PED",
                    },
                    {
                        name = "Clay",
                        model = "cs_clay",
                        type = "PED",
                    },
                    {
                        name = "Dale",
                        model = "cs_dale",
                        type = "PED",
                    },
                    {
                        name = "Dave Norton",
                        model = "cs_davenorton",
                        type = "PED",
                    },
                    {
                        name = "Debra",
                        model = "cs_debra",
                        type = "PED",
                    },
                    {
                        name = "Denise",
                        model = "cs_denise",
                        type = "PED",
                    },
                    {
                        name = "Devin",
                        model = "cs_devin",
                        type = "PED",
                    },
                    {
                        name = "Dom",
                        model = "cs_dom",
                        type = "PED",
                    },
                    {
                        name = "Peter Dreyfuss",
                        model = "cs_dreyfuss",
                        type = "PED",
                    },
                    {
                        name = "Dr Friedlander",
                        model = "cs_drfriedlander",
                        type = "PED",
                    },
                    {
                        name = "Dr Friedlander 2",
                        model = "CS_DrFriedlander_02",
                        type = "PED",
                    },
                    {
                        name = "Fabien",
                        model = "cs_fabien",
                        type = "PED",
                    },
                    {
                        name = "FBI Suit",
                        model = "cs_fbisuit_01",
                        type = "PED",
                    },
                    {
                        name = "Floyd",
                        model = "cs_floyd",
                        type = "PED",
                    },
                    {
                        name = "Guadalope",
                        model = "cs_guadalope",
                        type = "PED",
                    },
                    {
                        name = "Gurk",
                        model = "cs_gurk",
                        type = "PED",
                    },
                    {
                        name = "Hunter",
                        model = "cs_hunter",
                        type = "PED",
                    },
                    {
                        name = "Janet",
                        model = "cs_janet",
                        type = "PED",
                    },
                    {
                        name = "Jewelery Assistant",
                        model = "cs_jewelass",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Boston",
                        model = "cs_jimmyboston",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Disanto",
                        model = "cs_jimmydisanto",
                        type = "PED",
                    },
                    {
                        name = "Joe Minuteman",
                        model = "cs_joeminuteman",
                        type = "PED",
                    },
                    {
                        name = "Johnny Klebitz",
                        model = "cs_johnnyklebitz",
                        type = "PED",
                    },
                    {
                        name = "Josef",
                        model = "cs_josef",
                        type = "PED",
                    },
                    {
                        name = "Josh",
                        model = "cs_josh",
                        type = "PED",
                    },
                    {
                        name = "Karen Daniels",
                        model = "cs_karen_daniels",
                        type = "PED",
                    },
                    {
                        name = "Lamar Davis",
                        model = "cs_lamardavis",
                        type = "PED",
                    },
                    {
                        name = "Lazlow",
                        model = "cs_lazlow",
                        type = "PED",
                    },
                    {
                        name = "Lester Crest",
                        model = "cs_lestercrest",
                        type = "PED",
                    },
                    {
                        name = "Lester Crest 2",
                        model = "cs_lestercrest_2",
                        type = "PED",
                    },
                    {
                        name = "Rickie Lukens",
                        model = "cs_lifeinvad_01",
                        type = "PED",
                    },
                    {
                        name = "Magenta",
                        model = "cs_magenta",
                        type = "PED",
                    },
                    {
                        name = "Manuel",
                        model = "cs_manuel",
                        type = "PED",
                    },
                    {
                        name = "Marnie",
                        model = "cs_marnie",
                        type = "PED",
                    },
                    {
                        name = "Martin Madrazo",
                        model = "cs_martinmadrazo",
                        type = "PED",
                    },
                    {
                        name = "Mary Ann",
                        model = "cs_maryann",
                        type = "PED",
                    },
                    {
                        name = "Michelle",
                        model = "cs_michelle",
                        type = "PED",
                    },
                    {
                        name = "Milton",
                        model = "cs_milton",
                        type = "PED",
                    },
                    {
                        name = "Molly",
                        model = "cs_molly",
                        type = "PED",
                    },
                    {
                        name = "Movie Premier Female",
                        model = "cs_movpremf_01",
                        type = "PED",
                    },
                    {
                        name = "Movie Premier Male",
                        model = "cs_movpremmale",
                        type = "PED",
                    },
                    {
                        name = "Mark",
                        model = "cs_mrk",
                        type = "PED",
                    },
                    {
                        name = "Mrs Thornhill",
                        model = "cs_mrs_thornhill",
                        type = "PED",
                    },
                    {
                        name = "Mrs Phillips",
                        model = "cs_mrsphillips",
                        type = "PED",
                    },
                    {
                        name = "Natalia",
                        model = "cs_natalia",
                        type = "PED",
                    },
                    {
                        name = "Nervous Ron",
                        model = "cs_nervousron",
                        type = "PED",
                    },
                    {
                        name = "Nervous Ron 2",
                        model = "CS_NervousRon_02",
                        type = "PED",
                    },
                    {
                        name = "Nigel",
                        model = "cs_nigel",
                        type = "PED",
                    },
                    {
                        name = "Old Man 1",
                        model = "cs_old_man1a",
                        type = "PED",
                    },
                    {
                        name = "Old Man 2",
                        model = "cs_old_man2",
                        type = "PED",
                    },
                    {
                        name = "Omega",
                        model = "cs_omega",
                        type = "PED",
                    },
                    {
                        name = "Bigfoot",
                        model = "cs_orleans",
                        type = "PED",
                    },
                    {
                        name = "Agent ULP",
                        model = "cs_paper",
                        type = "PED",
                    },
                    {
                        name = "Patricia",
                        model = "cs_patricia",
                        type = "PED",
                    },
                    {
                        name = "Priest",
                        model = "cs_priest",
                        type = "PED",
                    },
                    {
                        name = "Prologue Security 2",
                        model = "cs_prolsec_02",
                        type = "PED",
                    },
                    {
                        name = "Russian Drunk",
                        model = "cs_russiandrunk",
                        type = "PED",
                    },
                    {
                        name = "Simeon Yetarian",
                        model = "cs_siemonyetarian",
                        type = "PED",
                    },
                    {
                        name = "Solomon",
                        model = "cs_solomon",
                        type = "PED",
                    },
                    {
                        name = "Steve Hains",
                        model = "cs_stevehains",
                        type = "PED",
                    },
                    {
                        name = "Stretch",
                        model = "cs_stretch",
                        type = "PED",
                    },
                    {
                        name = "Tanisha",
                        model = "cs_tanisha",
                        type = "PED",
                    },
                    {
                        name = "Tao Cheng",
                        model = "cs_taocheng",
                        type = "PED",
                    },
                    {
                        name = "Taos Translator",
                        model = "cs_taostranslator",
                        type = "PED",
                    },
                    {
                        name = "Tennis Coach",
                        model = "cs_tenniscoach",
                        type = "PED",
                    },
                    {
                        name = "Terry",
                        model = "cs_terry",
                        type = "PED",
                    },
                    {
                        name = "Tom",
                        model = "cs_tom",
                        type = "PED",
                    },
                    {
                        name = "Tom Epsilon",
                        model = "cs_tomepsilon",
                        type = "PED",
                    },
                    {
                        name = "Tracy Disanto",
                        model = "cs_tracydisanto",
                        type = "PED",
                    },
                    {
                        name = "Wade",
                        model = "cs_wade",
                        type = "PED",
                    },
                    {
                        name = "Zimbor",
                        model = "cs_zimbor",
                        type = "PED",
                    },
                    {
                        name = "Abigail",
                        model = "csb_abigail",
                        type = "PED",
                    },
                    {
                        name = "Agent",
                        model = "csb_agent",
                        type = "PED",
                    },
                    {
                        name = "Alan",
                        model = "csb_alan",
                        type = "PED",
                    },
                    {
                        name = "Anita",
                        model = "csb_anita",
                        type = "PED",
                    },
                    {
                        name = "Anton",
                        model = "csb_anton",
                        type = "PED",
                    },
                    {
                        name = "Avon",
                        model = "csb_avon",
                        type = "PED",
                    },
                    {
                        name = "Ballas OG",
                        model = "csb_ballasog",
                        type = "PED",
                    },
                    {
                        name = "Bogdan",
                        model = "csb_bogdan",
                        type = "PED",
                    },
                    {
                        name = "Bride",
                        model = "csb_bride",
                        type = "PED",
                    },
                    {
                        name = "BurgerShot Drug Dealer",
                        model = "csb_burgerdrug",
                        type = "PED",
                    },
                    {
                        name = "Bryony",
                        model = "csb_bryony",
                        type = "PED",
                    },
                    {
                        name = "Car guy 1",
                        model = "csb_car3guy1",
                        type = "PED",
                    },
                    {
                        name = "Car guy 2",
                        model = "csb_car3guy2",
                        type = "PED",
                    },
                    {
                        name = "Chef",
                        model = "csb_chef",
                        type = "PED",
                    },
                    {
                        name = "Chef 2",
                        model = "csb_chef2",
                        type = "PED",
                    },
                    {
                        name = "Chef 3",
                        model = "CSB_Chef_03",
                        type = "PED",
                    },
                    {
                        name = "Chinese Goon",
                        model = "csb_chin_goon",
                        type = "PED",
                    },
                    {
                        name = "Cletus",
                        model = "csb_cletus",
                        type = "PED",
                    },
                    {
                        name = "Cop",
                        model = "csb_cop",
                        type = "PED",
                    },
                    {
                        name = "Customer",
                        model = "csb_customer",
                        type = "PED",
                    },
                    {
                        name = "Dax",
                        model = "CSB_Dax",
                        type = "PED",
                    },
                    {
                        name = "Denise Friend",
                        model = "csb_denise_friend",
                        type = "PED",
                    },
                    {
                        name = "FOS Rep",
                        model = "csb_fos_rep",
                        type = "PED",
                    },
                    {
                        name = "csb_g",
                        model = "csb_g",
                        type = "PED",
                    },
                    {
                        name = "Groom",
                        model = "csb_groom",
                        type = "PED",
                    },
                    {
                        name = "Grove Street Dealer",
                        model = "csb_grove_str_dlr",
                        type = "PED",
                    },
                    {
                        name = "Hao",
                        model = "csb_hao",
                        type = "PED",
                    },
                    {
                        name = "Hugh",
                        model = "csb_hugh",
                        type = "PED",
                    },
                    {
                        name = "csb_imran",
                        model = "csb_imran",
                        type = "PED",
                    },
                    {
                        name = "Jack Howitzer",
                        model = "csb_jackhowitzer",
                        type = "PED",
                    },
                    {
                        name = "Janitor",
                        model = "csb_janitor",
                        type = "PED",
                    },
                    {
                        name = "Luchadora",
                        model = "CSB_Luchadora",
                        type = "PED",
                    },
                    {
                        name = "Lab Rat",
                        model = "CSB_Labrat",
                        type = "PED",
                    },
                    {
                        name = "Maude",
                        model = "csb_maude",
                        type = "PED",
                    },
                    {
                        name = "Money",
                        model = "csb_money",
                        type = "PED",
                    },
                    {
                        name = "Agent 14",
                        model = "csb_mp_agent14",
                        type = "PED",
                    },
                    {
                        name = "Phoenicia Rackman",
                        model = "csb_mrs_r",
                        type = "PED",
                    },
                    {
                        name = "Merryweather",
                        model = "csb_mweather",
                        type = "PED",
                    },
                    {
                        name = "Ortega",
                        model = "csb_ortega",
                        type = "PED",
                    },
                    {
                        name = "Oscar",
                        model = "csb_oscar",
                        type = "PED",
                    },
                    {
                        name = "Paige",
                        model = "csb_paige",
                        type = "PED",
                    },
                    {
                        name = "Dimitri Popov",
                        model = "csb_popov",
                        type = "PED",
                    },
                    {
                        name = "Porn Dudes",
                        model = "csb_porndudes",
                        type = "PED",
                    },
                    {
                        name = "Prologue Driver",
                        model = "csb_prologuedriver",
                        type = "PED",
                    },
                    {
                        name = "prologue Security",
                        model = "csb_prolsec",
                        type = "PED",
                    },
                    {
                        name = "Rampage Gang",
                        model = "csb_ramp_gang",
                        type = "PED",
                    },
                    {
                        name = "Rampage Hics",
                        model = "csb_ramp_hic",
                        type = "PED",
                    },
                    {
                        name = "Rampage Hipster",
                        model = "csb_ramp_hipster",
                        type = "PED",
                    },
                    {
                        name = "Rampage Marine",
                        model = "csb_ramp_marine",
                        type = "PED",
                    },
                    {
                        name = "Ramage Mexicans",
                        model = "csb_ramp_mex",
                        type = "PED",
                    },
                    {
                        name = "Rashcosvki",
                        model = "csb_rashcosvki",
                        type = "PED",
                    },
                    {
                        name = "Reporter",
                        model = "csb_reporter",
                        type = "PED",
                    },
                    {
                        name = "Roccope Pelosi",
                        model = "csb_roccopelosi",
                        type = "PED",
                    },
                    {
                        name = "Screen Writer",
                        model = "csb_screen_writer",
                        type = "PED",
                    },
                    {
                        name = "Stripper 1",
                        model = "csb_stripper_01",
                        type = "PED",
                    },
                    {
                        name = "Stripper 2",
                        model = "csb_stripper_02",
                        type = "PED",
                    },
                    {
                        name = "Tonya",
                        model = "csb_tonya",
                        type = "PED",
                    },
                    {
                        name = "Traffic Warden",
                        model = "csb_trafficwarden",
                        type = "PED",
                    },
                    {
                        name = "Undercover",
                        model = "csb_undercover",
                        type = "PED",
                    },
                    {
                        name = "Vagos Funeral Speaker",
                        model = "csb_vagspeak",
                        type = "PED",
                    },

                }
            },
            {
                name = "Gang Members",
                is_folder = true,
                items = {
                    {
                        name = "Female Import Export",
                        model = "g_f_importexport_01",
                        type = "PED",
                    },
                    {
                        name = "Ballas Female",
                        model = "g_f_y_ballas_01",
                        type = "PED",
                    },
                    {
                        name = "Grove Street Female",
                        model = "g_f_y_families_01",
                        type = "PED",
                    },
                    {
                        name = "Fooliganz",
                        model = "G_F_M_Fooliganz_01",
                        type = "PED",
                    },
                    {
                        name = "Lost MC Female",
                        model = "g_f_y_lost_01",
                        type = "PED",
                    },
                    {
                        name = "Vagos Female",
                        model = "g_f_y_vagos_01",
                        type = "PED",
                    },
                    {
                        name = "Male Import Export",
                        model = "g_m_importexport_01",
                        type = "PED",
                    },
                    {
                        name = "Armenian Boss",
                        model = "g_m_m_armboss_01",
                        type = "PED",
                    },
                    {
                        name = "Armenian Goon 1",
                        model = "g_m_m_armgoon_01",
                        type = "PED",
                    },
                    {
                        name = "Armenian Lieutenant",
                        model = "g_m_m_armlieut_01",
                        type = "PED",
                    },
                    {
                        name = "Chem Plant Worker",
                        model = "g_m_m_chemwork_01",
                        type = "PED",
                    },
                    {
                        name = "Chinese Boss",
                        model = "g_m_m_chiboss_01",
                        type = "PED",
                    },
                    {
                        name = "Older Chinese Goon",
                        model = "g_m_m_chicold_01",
                        type = "PED",
                    },
                    {
                        name = "Chinese Goon 1",
                        model = "g_m_m_chigoon_01",
                        type = "PED",
                    },
                    {
                        name = "Chinese Goon 2",
                        model = "g_m_m_chigoon_02",
                        type = "PED",
                    },
                    {
                        name = "Korean Boss 1",
                        model = "g_m_m_korboss_01",
                        type = "PED",
                    },
                    {
                        name = "Mexican Boss 1",
                        model = "g_m_m_mexboss_01",
                        type = "PED",
                    },
                    {
                        name = "Mexican Boss 2",
                        model = "g_m_m_mexboss_02",
                        type = "PED",
                    },
                    {
                        name = "Armenian Goon 2",
                        model = "g_m_y_armgoon_02",
                        type = "PED",
                    },
                    {
                        name = "Azteca",
                        model = "g_m_y_azteca_01",
                        type = "PED",
                    },
                    {
                        name = "Ballas Easy",
                        model = "g_m_y_ballaeast_01",
                        type = "PED",
                    },
                    {
                        name = "Ballas Original",
                        model = "g_m_y_ballaorig_01",
                        type = "PED",
                    },
                    {
                        name = "Ballas South",
                        model = "g_m_y_ballasout_01",
                        type = "PED",
                    },
                    {
                        name = "Grove Street 1",
                        model = "g_m_y_famca_01",
                        type = "PED",
                    },
                    {
                        name = "Grove Street 2",
                        model = "g_m_y_famdnf_01",
                        type = "PED",
                    },
                    {
                        name = "Grove Street 3",
                        model = "g_m_y_famfor_01",
                        type = "PED",
                    },
                    {
                        name = "Korean Goon 1",
                        model = "g_m_y_korean_01",
                        type = "PED",
                    },
                    {
                        name = "Korean Goon 2",
                        model = "g_m_y_korean_02",
                        type = "PED",
                    },
                    {
                        name = "Korean Lieutenant",
                        model = "g_m_y_korlieut_01",
                        type = "PED",
                    },
                    {
                        name = "Lost 1",
                        model = "g_m_y_lost_01",
                        type = "PED",
                    },
                    {
                        name = "Lost 2",
                        model = "g_m_y_lost_02",
                        type = "PED",
                    },
                    {
                        name = "Lost 3",
                        model = "g_m_y_lost_03",
                        type = "PED",
                    },
                    {
                        name = "Mexican Gang",
                        model = "g_m_y_mexgang_01",
                        type = "PED",
                    },
                    {
                        name = "Mexican Goon 1",
                        model = "g_m_y_mexgoon_01",
                        type = "PED",
                    },
                    {
                        name = "Mexican Goon 2",
                        model = "g_m_y_mexgoon_02",
                        type = "PED",
                    },
                    {
                        name = "Mexican Goon 3",
                        model = "g_m_y_mexgoon_03",
                        type = "PED",
                    },
                    {
                        name = "Polynesian Goon 1",
                        model = "g_m_y_pologoon_01",
                        type = "PED",
                    },
                    {
                        name = "Polynesian Goon 2",
                        model = "g_m_y_pologoon_02",
                        type = "PED",
                    },
                    {
                        name = "Salvadoran Boss",
                        model = "g_m_y_salvaboss_01",
                        type = "PED",
                    },
                    {
                        name = "Salvadoran Goon 1",
                        model = "g_m_y_salvagoon_01",
                        type = "PED",
                    },
                    {
                        name = "Salvadoran Goon 2",
                        model = "g_m_y_salvagoon_02",
                        type = "PED",
                    },
                    {
                        name = "Salvadoran Goon 3",
                        model = "g_m_y_salvagoon_03",
                        type = "PED",
                    },
                    {
                        name = "Street Punk 1",
                        model = "g_m_y_strpunk_01",
                        type = "PED",
                    },
                    {
                        name = "Street Punk 2",
                        model = "g_m_y_strpunk_02",
                        type = "PED",
                    },
                }
            },
            {
                name = "Multiplayer",
                is_folder = true,
                items = {
                    {
                        name = "Benny Mechanic",
                        model = "mp_f_bennymech_01",
                        type = "PED",
                    },
                    {
                        name = "Female Boat Staff",
                        model = "mp_f_boatstaff_01",
                        type = "PED",
                    },
                    {
                        name = "Female Car Designer",
                        model = "mp_f_cardesign_01",
                        type = "PED",
                    },
                    {
                        name = "Female Bartender",
                        model = "mp_f_chbar_01",
                        type = "PED",
                    },
                    {
                        name = "Female Cocaine Worker",
                        model = "mp_f_cocaine_01",
                        type = "PED",
                    },
                    {
                        name = "Female Counterfeit Worker",
                        model = "mp_f_counterfeit_01",
                        type = "PED",
                    },
                    {
                        name = "Dead Hooker",
                        model = "mp_f_deadhooker",
                        type = "PED",
                    },
                    {
                        name = "Female Executive Assistant ",
                        model = "mp_f_execpa_01",
                        type = "PED",
                    },
                    {
                        name = "Female Executive Assistant 2",
                        model = "mp_f_execpa_02",
                        type = "PED",
                    },
                    {
                        name = "Female Forgery Worker",
                        model = "mp_f_forgery_01",
                        type = "PED",
                    },
                    {
                        name = "Female Freemode",
                        model = "mp_f_freemode_01",
                        type = "PED",
                    },
                    {
                        name = "Female Helistaff",
                        model = "mp_f_helistaff_01",
                        type = "PED",
                    },
                    {
                        name = "Female Meth Worker",
                        model = "mp_f_meth_01",
                        type = "PED",
                    },
                    {
                        name = "Misty",
                        model = "mp_f_misty_01",
                        type = "PED",
                    },
                    {
                        name = "Stripper",
                        model = "mp_f_stripperlite",
                        type = "PED",
                    },
                    {
                        name = "Female Weed Worker",
                        model = "mp_f_weed_01",
                        type = "PED",
                    },
                    {
                        name = "Heist Goons",
                        model = "mp_g_m_pros_01",
                        type = "PED",
                    },
                    {
                        name = "Avon Goon",
                        model = "mp_m_avongoon",
                        type = "PED",
                    },
                    {
                        name = "Male Boat Staff",
                        model = "mp_m_boatstaff_01",
                        type = "PED",
                    },
                    {
                        name = "Bogdan Goon",
                        model = "mp_m_bogdangoon",
                        type = "PED",
                    },
                    {
                        name = "Claude",
                        model = "mp_m_claude_01",
                        type = "PED",
                    },
                    {
                        name = "Male Cocaine Worker",
                        model = "mp_m_cocaine_01",
                        type = "PED",
                    },
                    {
                        name = "Male Counterfeit Worker",
                        model = "mp_m_counterfeit_01",
                        type = "PED",
                    },
                    {
                        name = "Ex Army Vet",
                        model = "mp_m_exarmy_01",
                        type = "PED",
                    },
                    {
                        name = "Male exec PA",
                        model = "mp_m_execpa_01",
                        type = "PED",
                    },
                    {
                        name = "Grove Street",
                        model = "mp_m_famdd_01",
                        type = "PED",
                    },
                    {
                        name = "Male FIB Secretary",
                        model = "mp_m_fibsec_01",
                        type = "PED",
                    },
                    {
                        name = "Male Forgery Worker",
                        model = "mp_m_forgery_01",
                        type = "PED",
                    },
                    {
                        name = "Male Freemode",
                        model = "mp_m_freemode_01",
                        type = "PED",
                    },
                    {
                        name = "John Marston",
                        model = "mp_m_marston_01",
                        type = "PED",
                    },
                    {
                        name = "Male Meth Worker",
                        model = "mp_m_meth_01",
                        type = "PED",
                    },
                    {
                        name = "Niko Belic",
                        model = "mp_m_niko_01",
                        type = "PED",
                    },
                    {
                        name = "Securo Guard",
                        model = "mp_m_securoguard_01",
                        type = "PED",
                    },
                    {
                        name = "Male Shopkeep",
                        model = "mp_m_shopkeep_01",
                        type = "PED",
                    },
                    {
                        name = "Warehouse Mechanic",
                        model = "mp_m_waremech_01",
                        type = "PED",
                    },
                    {
                        name = "Male Weed Worker",
                        model = "mp_m_weed_01",
                        type = "PED",
                    },
                    {
                        name = "Vagos Funeral",
                        model = "mp_m_g_vagfun_01",
                        type = "PED",
                    },
                    {
                        name = "Male Armoured",
                        model = "mp_s_m_armoured_01",
                        type = "PED",
                    },
                    {
                        name = "Weapons Expert",
                        model = "mp_m_weapexp_01",
                        type = "PED",
                    },
                    {
                        name = "Weapons Worker",
                        model = "mp_m_weapwork_01",
                        type = "PED",
                    },
                }
            },
            {
                name = "MP Scenario Females",
                is_folder = true,
                items = {
                    {
                        name = "Barber",
                        model = "s_f_m_fembarber",
                        type = "PED",
                    },
                    {
                        name = "Maid",
                        model = "s_f_m_maid_01",
                        type = "PED",
                    },
                    {
                        name = "Highend Shop Keeper",
                        model = "s_f_m_shop_high",
                        type = "PED",
                    },
                    {
                        name = "Sweatshop Worker",
                        model = "s_f_m_sweatshop_01",
                        type = "PED",
                    },
                    {
                        name = "Air Hostess",
                        model = "s_f_y_airhostess_01",
                        type = "PED",
                    },
                    {
                        name = "Bartender",
                        model = "s_f_y_bartender_01",
                        type = "PED",
                    },
                    {
                        name = "Lifguard",
                        model = "s_f_y_baywatch_01",
                        type = "PED",
                    },
                    {
                        name = "Cop",
                        model = "s_f_y_cop_01",
                        type = "PED",
                    },
                    {
                        name = "Factory Worker",
                        model = "s_f_y_factory_01",
                        type = "PED",
                    },
                    {
                        name = "Hooker 1",
                        model = "s_f_y_hooker_01",
                        type = "PED",
                    },
                    {
                        name = "Hooker 2",
                        model = "s_f_y_hooker_02",
                        type = "PED",
                    },
                    {
                        name = "Hooker 3",
                        model = "s_f_y_hooker_03",
                        type = "PED",
                    },
                    {
                        name = "Migrant",
                        model = "s_f_y_migrant_01",
                        type = "PED",
                    },
                    {
                        name = "Movie Premier",
                        model = "s_f_y_movprem_01",
                        type = "PED",
                    },
                    {
                        name = "Ranger",
                        model = "s_f_y_ranger_01",
                        type = "PED",
                    },
                    {
                        name = "Nurse Scrubs",
                        model = "s_f_y_scrubs_01",
                        type = "PED",
                    },
                    {
                        name = "Sheriff",
                        model = "s_f_y_sheriff_01",
                        type = "PED",
                    },
                    {
                        name = "Low End Shop Keeper",
                        model = "s_f_y_shop_low",
                        type = "PED",
                    },
                    {
                        name = "Mid Level Shop Keeper",
                        model = "s_f_y_shop_mid",
                        type = "PED",
                    },
                    {
                        name = "Stripper 1",
                        model = "s_f_y_stripper_01",
                        type = "PED",
                    },
                    {
                        name = "Stripper 2",
                        model = "s_f_y_stripper_02",
                        type = "PED",
                    },
                    {
                        name = "Stripper 3",
                        model = "s_f_y_stripperlite",
                        type = "PED",
                    },
                    {
                        name = "Sweat Shop 2",
                        model = "s_f_y_sweatshop_01",
                        type = "PED",
                    },
                }
            },
            {
                name = "MP Scenario Males",
                is_folder = true,
                items = {
                    {
                        name = "Male Ammunation Clerk 1",
                        model = "s_m_m_ammucountry",
                        type = "PED",
                    },
                    {
                        name = "Armoured Male 1",
                        model = "s_m_m_armoured_01",
                        type = "PED",
                    },
                    {
                        name = "Armoured Male 2",
                        model = "s_m_m_armoured_02",
                        type = "PED",
                    },
                    {
                        name = "Autoshop 1",
                        model = "s_m_m_autoshop_01",
                        type = "PED",
                    },
                    {
                        name = "Autoshop 2",
                        model = "s_m_m_autoshop_02",
                        type = "PED",
                    },
                    {
                        name = "Bouncer",
                        model = "s_m_m_bouncer_01",
                        type = "PED",
                    },
                    {
                        name = "Aircraft Carrier Crew",
                        model = "s_m_m_ccrew_01",
                        type = "PED",
                    },
                    {
                        name = "Chem Plant Security",
                        model = "s_m_m_chemsec_01",
                        type = "PED",
                    },
                    {
                        name = "CIA Security",
                        model = "s_m_m_ciasec_01",
                        type = "PED",
                    },
                    {
                        name = "Country Bartender",
                        model = "s_m_m_cntrybar_01",
                        type = "PED",
                    },
                    {
                        name = "Dock Worker",
                        model = "s_m_m_dockwork_01",
                        type = "PED",
                    },
                    {
                        name = "Doctor",
                        model = "s_m_m_doctor_01",
                        type = "PED",
                    },
                    {
                        name = "FIB Office Worker 1",
                        model = "s_m_m_fiboffice_01",
                        type = "PED",
                    },
                    {
                        name = "FIB Office Worker 2",
                        model = "s_m_m_fiboffice_02",
                        type = "PED",
                    },
                    {
                        name = "FIB Security",
                        model = "s_m_m_fibsec_01",
                        type = "PED",
                    },
                    {
                        name = "Gaffer",
                        model = "s_m_m_gaffer_01",
                        type = "PED",
                    },
                    {
                        name = "Gardener",
                        model = "s_m_m_gardener_01",
                        type = "PED",
                    },
                    {
                        name = "General Transport Worker",
                        model = "s_m_m_gentransport",
                        type = "PED",
                    },
                    {
                        name = "Hair Dresser",
                        model = "s_m_m_hairdress_01",
                        type = "PED",
                    },
                    {
                        name = "Highend Security 1",
                        model = "s_m_m_highsec_01",
                        type = "PED",
                    },
                    {
                        name = "Highend Security 2",
                        model = "s_m_m_highsec_02",
                        type = "PED",
                    },
                    {
                        name = "Janitor",
                        model = "s_m_m_janitor",
                        type = "PED",
                    },
                    {
                        name = "Latino Handyman",
                        model = "s_m_m_lathandy_01",
                        type = "PED",
                    },
                    {
                        name = "Life Invader",
                        model = "s_m_m_lifeinvad_01",
                        type = "PED",
                    },
                    {
                        name = "Line Cook",
                        model = "s_m_m_linecook",
                        type = "PED",
                    },
                    {
                        name = "LS metro",
                        model = "s_m_m_lsmetro_01",
                        type = "PED",
                    },
                    {
                        name = "Mariachi Band",
                        model = "s_m_m_mariachi_01",
                        type = "PED",
                    },
                    {
                        name = "Marine 1",
                        model = "s_m_m_marine_01",
                        type = "PED",
                    },
                    {
                        name = "Marine2",
                        model = "s_m_m_marine_02",
                        type = "PED",
                    },
                    {
                        name = "Migrant",
                        model = "s_m_m_migrant_01",
                        type = "PED",
                    },
                    {
                        name = "Alien Costume",
                        model = "s_m_m_movalien_01",
                        type = "PED",
                    },
                    {
                        name = "Movie Premier",
                        model = "s_m_m_movprem_01",
                        type = "PED",
                    },
                    {
                        name = "Movie Astronaut",
                        model = "s_m_m_movspace_01",
                        type = "PED",
                    },
                    {
                        name = "Paramedic",
                        model = "s_m_m_paramedic_01",
                        type = "PED",
                    },
                    {
                        name = "Pilot 1",
                        model = "s_m_m_pilot_01",
                        type = "PED",
                    },
                    {
                        name = "Pilot 2",
                        model = "s_m_m_pilot_02",
                        type = "PED",
                    },
                    {
                        name = "Postal 1",
                        model = "s_m_m_postal_01",
                        type = "PED",
                    },
                    {
                        name = "Postal 2",
                        model = "s_m_m_postal_02",
                        type = "PED",
                    },
                    {
                        name = "Prison Guard",
                        model = "s_m_m_prisguard_01",
                        type = "PED",
                    },
                    {
                        name = "Scientist",
                        model = "s_m_m_scientist_01",
                        type = "PED",
                    },
                    {
                        name = "Security Guard",
                        model = "s_m_m_security_01",
                        type = "PED",
                    },
                    {
                        name = "Snow Cop",
                        model = "s_m_m_snowcop_01",
                        type = "PED",
                    },
                    {
                        name = "Street Performer",
                        model = "s_m_m_strperf_01",
                        type = "PED",
                    },
                    {
                        name = "Street Preacher",
                        model = "s_m_m_strpreach_01",
                        type = "PED",
                    },
                    {
                        name = "Street Vendor",
                        model = "s_m_m_strvend_01",
                        type = "PED",
                    },
                    {
                        name = "Trucker",
                        model = "s_m_m_trucker_01",
                        type = "PED",
                    },
                    {
                        name = "Ups 1",
                        model = "s_m_m_ups_01",
                        type = "PED",
                    },
                    {
                        name = "Ups 2",
                        model = "s_m_m_ups_02",
                        type = "PED",
                    },
                    {
                        name = "Busker",
                        model = "s_m_o_busker_01",
                        type = "PED",
                    },
                    {
                        name = "Airline Worker",
                        model = "s_m_y_airworker",
                        type = "PED",
                    },
                    {
                        name = "Ammunation City",
                        model = "s_m_y_ammucity_01",
                        type = "PED",
                    },
                    {
                        name = "Army Mechanic",
                        model = "s_m_y_armymech_01",
                        type = "PED",
                    },
                    {
                        name = "Autopsy Doc",
                        model = "s_m_y_autopsy_01",
                        type = "PED",
                    },
                    {
                        name = "Bartender",
                        model = "s_m_y_barman_01",
                        type = "PED",
                    },
                    {
                        name = "Lifguard",
                        model = "s_m_y_baywatch_01",
                        type = "PED",
                    },
                    {
                        name = "Blackops 1",
                        model = "s_m_y_blackops_01",
                        type = "PED",
                    },
                    {
                        name = "Blackops 2",
                        model = "s_m_y_blackops_02",
                        type = "PED",
                    },
                    {
                        name = "Blackops 3",
                        model = "s_m_y_blackops_03",
                        type = "PED",
                    },
                    {
                        name = "Busboy",
                        model = "s_m_y_busboy_01",
                        type = "PED",
                    },
                    {
                        name = "Chef",
                        model = "s_m_y_chef_01",
                        type = "PED",
                    },
                    {
                        name = "Clown",
                        model = "s_m_y_clown_01",
                        type = "PED",
                    },
                    {
                        name = "Construction 1",
                        model = "s_m_y_construct_01",
                        type = "PED",
                    },
                    {
                        name = "Construction 2",
                        model = "s_m_y_construct_02",
                        type = "PED",
                    },
                    {
                        name = "Cop",
                        model = "s_m_y_cop_01",
                        type = "PED",
                    },
                    {
                        name = "Dealer",
                        model = "s_m_y_dealer_01",
                        type = "PED",
                    },
                    {
                        name = "Devin Security",
                        model = "s_m_y_devinsec_01",
                        type = "PED",
                    },
                    {
                        name = "Dock Worker",
                        model = "s_m_y_dockwork_01",
                        type = "PED",
                    },
                    {
                        name = "Doorman",
                        model = "s_m_y_doorman_01",
                        type = "PED",
                    },
                    {
                        name = "Airport Service 1",
                        model = "s_m_y_dwservice_01",
                        type = "PED",
                    },
                    {
                        name = "Airport Service ",
                        model = "s_m_y_dwservice_02",
                        type = "PED",
                    },
                    {
                        name = "Factory Worker",
                        model = "s_m_y_factory_01",
                        type = "PED",
                    },
                    {
                        name = "Fireman",
                        model = "s_m_y_fireman_01",
                        type = "PED",
                    },
                    {
                        name = "Garbage Collector",
                        model = "s_m_y_garbage",
                        type = "PED",
                    },
                    {
                        name = "Vinewood Grip",
                        model = "s_m_y_grip_01",
                        type = "PED",
                    },
                    {
                        name = "Highway Cop",
                        model = "s_m_y_hwaycop_01",
                        type = "PED",
                    },
                    {
                        name = "Young Marine 1",
                        model = "s_m_y_marine_01",
                        type = "PED",
                    },
                    {
                        name = "Young Marine 2",
                        model = "s_m_y_marine_02",
                        type = "PED",
                    },
                    {
                        name = "Young Marine 3",
                        model = "s_m_y_marine_03",
                        type = "PED",
                    },
                    {
                        name = "Mime",
                        model = "s_m_y_mime",
                        type = "PED",
                    },
                    {
                        name = "Pest Control",
                        model = "s_m_y_pestcont_01",
                        type = "PED",
                    },
                    {
                        name = "Pilot",
                        model = "s_m_y_pilot_01",
                        type = "PED",
                    },
                    {
                        name = "Prisoner Muscular",
                        model = "s_m_y_prismuscl_01",
                        type = "PED",
                    },
                    {
                        name = "Prisoner",
                        model = "s_m_y_prisoner_01",
                        type = "PED",
                    },
                    {
                        name = "Ranger",
                        model = "s_m_y_ranger_01",
                        type = "PED",
                    },
                    {
                        name = "Robber",
                        model = "s_m_y_robber_01",
                        type = "PED",
                    },
                    {
                        name = "Sheriff",
                        model = "s_m_y_sheriff_01",
                        type = "PED",
                    },
                    {
                        name = "Shop Mask Vendor",
                        model = "s_m_y_shop_mask",
                        type = "PED",
                    },
                    {
                        name = "Young street Vendor",
                        model = "s_m_y_strvend_01",
                        type = "PED",
                    },
                    {
                        name = "SWAT",
                        model = "s_m_y_swat_01",
                        type = "PED",
                    },
                    {
                        name = "US Coast Guard",
                        model = "s_m_y_uscg_01",
                        type = "PED",
                    },
                    {
                        name = "Valet",
                        model = "s_m_y_valet_01",
                        type = "PED",
                    },
                    {
                        name = "Waiter",
                        model = "s_m_y_waiter_01",
                        type = "PED",
                    },
                    {
                        name = "Window Cleaner",
                        model = "s_m_y_winclean_01",
                        type = "PED",
                    },
                    {
                        name = "Mechanic",
                        model = "s_m_y_xmech_01",
                        type = "PED",
                    },
                    {
                        name = "Mechanic MP",
                        model = "s_m_y_xmech_02_mp",
                        type = "PED",
                    },

                }
            },
            {
                name = "Story Mode",
                is_folder = true,
                items = {
                    {
                        name = "Heist Crew Driver",
                        model = "hc_driver",
                        type = "PED",
                    },
                    {
                        name = "Heist Crew Gunman",
                        model = "hc_gunman",
                        type = "PED",
                    },
                    {
                        name = "Heist Crew Hacker",
                        model = "hc_hacker",
                        type = "PED",
                    },
                    {
                        name = "Abigail",
                        model = "ig_abigail",
                        type = "PED",
                    },
                    {
                        name = "Acid Lab Cook",
                        model = "IG_AcidLabCook",
                        type = "PED",
                    },
                    {
                        name = "Agent",
                        model = "ig_agent",
                        type = "PED",
                    },
                    {
                        name = "Amanda Townley",
                        model = "ig_amandatownley",
                        type = "PED",
                    },
                    {
                        name = "Andreas",
                        model = "ig_andreas",
                        type = "PED",
                    },
                    {
                        name = "Ashley",
                        model = "ig_ashley",
                        type = "PED",
                    },
                    {
                        name = "Avon",
                        model = "ig_avon",
                        type = "PED",
                    },
                    {
                        name = "Ballas OG",
                        model = "ig_ballasog",
                        type = "PED",
                    },
                    {
                        name = "Bankman",
                        model = "ig_bankman",
                        type = "PED",
                    },
                    {
                        name = "Barry",
                        model = "ig_barry",
                        type = "PED",
                    },
                    {
                        name = "Benny",
                        model = "ig_benny",
                        type = "PED",
                    },
                    {
                        name = "Bestmen Wedding",
                        model = "ig_bestmen",
                        type = "PED",
                    },
                    {
                        name = "Beverly",
                        model = "ig_beverly",
                        type = "PED",
                    },
                    {
                        name = "Brad",
                        model = "ig_brad",
                        type = "PED",
                    },
                    {
                        name = "Bride",
                        model = "ig_bride",
                        type = "PED",
                    },
                    {
                        name = "Car Guy 1",
                        model = "ig_car3guy1",
                        type = "PED",
                    },
                    {
                        name = "Car Guy 2",
                        model = "ig_car3guy2",
                        type = "PED",
                    },
                    {
                        name = "Casey",
                        model = "ig_casey",
                        type = "PED",
                    },
                    {
                        name = "Chef",
                        model = "ig_chef",
                        type = "PED",
                    },
                    {
                        name = "Chef 2",
                        model = "ig_chef2",
                        type = "PED",
                    },
                    {
                        name = "Chef 3",
                        model = "IG_Chef_03",
                        type = "PED",
                    },
                    {
                        name = "Cheng SR",
                        model = "ig_chengsr",
                        type = "PED",
                    },
                    {
                        name = "Chris Formage",
                        model = "ig_chrisformage",
                        type = "PED",
                    },
                    {
                        name = "Clay",
                        model = "ig_clay",
                        type = "PED",
                    },
                    {
                        name = "Clay Pain",
                        model = "ig_claypain",
                        type = "PED",
                    },
                    {
                        name = "Cletus",
                        model = "ig_cletus",
                        type = "PED",
                    },
                    {
                        name = "Dale",
                        model = "ig_dale",
                        type = "PED",
                    },
                    {
                        name = "Dave Norton",
                        model = "ig_davenorton",
                        type = "PED",
                    },
                    {
                        name = "Dax",
                        model = "IG_Dax",
                        type = "PED",
                    },
                    {
                        name = "Denise",
                        model = "ig_denise",
                        type = "PED",
                    },
                    {
                        name = "Devin",
                        model = "ig_devin",
                        type = "PED",
                    },
                    {
                        name = "Dom",
                        model = "ig_dom",
                        type = "PED",
                    },
                    {
                        name = "Peter Dreyfuss",
                        model = "ig_dreyfuss",
                        type = "PED",
                    },
                    {
                        name = "Dr Friedlander",
                        model = "ig_drfriedlander",
                        type = "PED",
                    },
                    {
                        name = "Dr Friedlander 2",
                        model = "IG_DrFriedlander_02",
                        type = "PED",
                    },
                    {
                        name = "Fabien",
                        model = "ig_fabien",
                        type = "PED",
                    },
                    {
                        name = "Fbi Suit",
                        model = "ig_fbisuit_01",
                        type = "PED",
                    },
                    {
                        name = "Floyd",
                        model = "ig_floyd",
                        type = "PED",
                    },
                    {
                        name = "Franklin",
                        model = "player_one",
                        type = "PED",
                    },
                    {
                        name = "Furry",
                        model = "IG_Furry",
                        type = "PED",
                    },
                    {
                        name = "Fooliganz 1",
                        model = "IG_Fooliganz_01",
                        type = "PED",
                    },
                    {
                        name = "Fooliganz 2",
                        model = "IG_Fooliganz_02",
                        type = "PED",
                    },
                    {
                        name = "Gerald",
                        model = "ig_g",
                        type = "PED",
                    },
                    {
                        name = "Groom",
                        model = "ig_groom",
                        type = "PED",
                    },
                    {
                        name = "Gun Van Seller",
                        model = "IG_GunVanSeller",
                        type = "PED",
                    },
                    {
                        name = "Hao",
                        model = "ig_hao",
                        type = "PED",
                    },
                    {
                        name = "Hippy Leader",
                        model = "IG_HippyLeader",
                        type = "PED",
                    },
                    {
                        name = "Hunter",
                        model = "ig_hunter",
                        type = "PED",
                    },
                    {
                        name = "Janet",
                        model = "ig_janet",
                        type = "PED",
                    },
                    {
                        name = "Jay Norris",
                        model = "ig_jay_norris",
                        type = "PED",
                    },
                    {
                        name = "Jewel Assitant",
                        model = "ig_jewelass",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Boston",
                        model = "ig_jimmyboston",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Disanto",
                        model = "ig_jimmydisanto",
                        type = "PED",
                    },
                    {
                        name = "Joe Minuteman",
                        model = "ig_joeminuteman",
                        type = "PED",
                    },
                    {
                        name = "Johnny Klebitz",
                        model = "ig_johnnyklebitz",
                        type = "PED",
                    },
                    {
                        name = "Jose",
                        model = "ig_josef",
                        type = "PED",
                    },
                    {
                        name = "Josh",
                        model = "ig_josh",
                        type = "PED",
                    },
                    {
                        name = "Karen Daniels",
                        model = "ig_karen_daniels",
                        type = "PED",
                    },
                    {
                        name = "Kerry Mcintosh",
                        model = "ig_kerrymcintosh",
                        type = "PED",
                    },
                    {
                        name = "Lab Rat",
                        model = "IG_Labrat",
                        type = "PED",
                    },
                    {
                        name = "Lamar Davis",
                        model = "ig_lamardavis",
                        type = "PED",
                    },
                    {
                        name = "Lazlow",
                        model = "ig_lazlow",
                        type = "PED",
                    },
                    {
                        name = "Lester Crest",
                        model = "ig_lestercrest",
                        type = "PED",
                    },
                    {
                        name = "Lester Crest 2",
                        model = "ig_lestercrest_2",
                        type = "PED",
                    },
                    {
                        name = "Rickie Lukens",
                        model = "ig_lifeinvad_01",
                        type = "PED",
                    },
                    {
                        name = "Lifeinvader Employee",
                        model = "ig_lifeinvad_02",
                        type = "PED",
                    },
                    {
                        name = "Luchadora",
                        model = "IG_Luchadora",
                        type = "PED",
                    },
                    {
                        name = "Magenta",
                        model = "ig_magenta",
                        type = "PED",
                    },
                    {
                        name = "Malc",
                        model = "ig_malc",
                        type = "PED",
                    },
                    {
                        name = "Manuel",
                        model = "ig_manuel",
                        type = "PED",
                    },
                    {
                        name = "Marnie",
                        model = "ig_marnie",
                        type = "PED",
                    },
                    {
                        name = "Mary Ann",
                        model = "ig_maryann",
                        type = "PED",
                    },
                    {
                        name = "Maude",
                        model = "ig_maude",
                        type = "PED",
                    },
                    {
                        name = "Michael",
                        model = "player_zero",
                        type = "PED",
                    },
                    {
                        name = "Michelle",
                        model = "ig_michelle",
                        type = "PED",
                    },
                    {
                        name = "Milton",
                        model = "ig_milton",
                        type = "PED",
                    },
                    {
                        name = "Molly",
                        model = "ig_molly",
                        type = "PED",
                    },
                    {
                        name = "Money",
                        model = "ig_money",
                        type = "PED",
                    },
                    {
                        name = "MP Agent 14",
                        model = "ig_mp_agent14",
                        type = "PED",
                    },
                    {
                        name = "Torture Victim",
                        model = "ig_mrk",
                        type = "PED",
                    },
                    {
                        name = "Mrs Thornhill",
                        model = "ig_mrs_thornhill",
                        type = "PED",
                    },
                    {
                        name = "Mrs Phillips",
                        model = "ig_mrsphillips",
                        type = "PED",
                    },
                    {
                        name = "Natalia",
                        model = "ig_natalia",
                        type = "PED",
                    },
                    {
                        name = "Nervous Ron",
                        model = "ig_nervousron",
                        type = "PED",
                    },
                    {
                        name = "Nervous Ron 2",
                        model = "IG_NervousRon_02",
                        type = "PED",
                    },
                    {
                        name = "Nigel",
                        model = "ig_nigel",
                        type = "PED",
                    },
                    {
                        name = "Old Man 1",
                        model = "ig_old_man1",
                        type = "PED",
                    },
                    {
                        name = "Old Man 2",
                        model = "ig_old_man2",
                        type = "PED",
                    },
                    {
                        name = "Omega",
                        model = "ig_omega",
                        type = "PED",
                    },
                    {
                        name = "Oneil Brothers",
                        model = "ig_oneil",
                        type = "PED",
                    },
                    {
                        name = "Bigfoot",
                        model = "ig_orleans",
                        type = "PED",
                    },
                    {
                        name = "Ortega",
                        model = "ig_ortega",
                        type = "PED",
                    },
                    {
                        name = "Paige",
                        model = "ig_paige",
                        type = "PED",
                    },
                    {
                        name = "Agent ULP",
                        model = "ig_paper",
                        type = "PED",
                    },
                    {
                        name = "Patricia",
                        model = "ig_patricia",
                        type = "PED",
                    },
                    {
                        name = "Dima Popov",
                        model = "ig_popov",
                        type = "PED",
                    },
                    {
                        name = "Priest",
                        model = "ig_priest",
                        type = "PED",
                    },
                    {
                        name = "Prologue Security",
                        model = "ig_prolsec_02",
                        type = "PED",
                    },
                    {
                        name = "Rampage Gang",
                        model = "ig_ramp_gang",
                        type = "PED",
                    },
                    {
                        name = "Rampage Hics",
                        model = "ig_ramp_hic",
                        type = "PED",
                    },
                    {
                        name = "Rampage Hipsters",
                        model = "ig_ramp_hipster",
                        type = "PED",
                    },
                    {
                        name = "Rampage Vagos",
                        model = "ig_ramp_mex",
                        type = "PED",
                    },
                    {
                        name = "Rashcosvki",
                        model = "ig_rashcosvki",
                        type = "PED",
                    },
                    {
                        name = "Rocco Pelosi",
                        model = "ig_roccopelosi",
                        type = "PED",
                    },
                    {
                        name = "Russian Drunk",
                        model = "ig_russiandrunk",
                        type = "PED",
                    },
                    {
                        name = "Sacha",
                        model = "ig_sacha",
                        type = "PED",
                    },
                    {
                        name = "Screen Writer",
                        model = "ig_screen_writer",
                        type = "PED",
                    },
                    {
                        name = "Simeon Yetarian",
                        model = "ig_siemonyetarian",
                        type = "PED",
                    },
                    {
                        name = "Solomon",
                        model = "ig_solomon",
                        type = "PED",
                    },
                    {
                        name = "Steve Hains",
                        model = "ig_stevehains",
                        type = "PED",
                    },
                    {
                        name = "Stretch",
                        model = "ig_stretch",
                        type = "PED",
                    },
                    {
                        name = "Talina",
                        model = "ig_talina",
                        type = "PED",
                    },
                    {
                        name = "Tanisha",
                        model = "ig_tanisha",
                        type = "PED",
                    },
                    {
                        name = "Tao Cheng",
                        model = "ig_taocheng",
                        type = "PED",
                    },
                    {
                        name = "Taos Translator",
                        model = "ig_taostranslator",
                        type = "PED",
                    },
                    {
                        name = "Tennis Coach",
                        model = "ig_tenniscoach",
                        type = "PED",
                    },
                    {
                        name = "Terry",
                        model = "ig_terry",
                        type = "PED",
                    },
                    {
                        name = "Tom Epsilon",
                        model = "ig_tomepsilon",
                        type = "PED",
                    },
                    {
                        name = "Tonya",
                        model = "ig_tonya",
                        type = "PED",
                    },
                    {
                        name = "Tracy Disanto",
                        model = "ig_tracydisanto",
                        type = "PED",
                    },
                    {
                        name = "Traffic Warden",
                        model = "ig_trafficwarden",
                        type = "PED",
                    },
                    {
                        name = "Trevor",
                        model = "player_two",
                        type = "PED",
                    },
                    {
                        name = "Tyler Dix",
                        model = "ig_tylerdix",
                        type = "PED",
                    },
                    {
                        name = "Vagos Funeral",
                        model = "ig_vagspeak",
                        type = "PED",
                    },
                    {
                        name = "Wade",
                        model = "ig_wade",
                        type = "PED",
                    },
                    {
                        name = "Zimbor",
                        model = "ig_zimbor",
                        type = "PED",
                    },


                }
            },
            {
                name = "Story Scenario Females",
                is_folder = true,
                items = {
                    {
                        name = "Corpse 1",
                        model = "u_f_m_corpse_01",
                        type = "PED",
                    },
                    {
                        name = "Drowned Body",
                        model = "u_f_m_drowned_01",
                        type = "PED",
                    },
                    {
                        name = "Miranda",
                        model = "u_f_m_miranda",
                        type = "PED",
                    },
                    {
                        name = "Mourner",
                        model = "u_f_m_promourn_01",
                        type = "PED",
                    },
                    {
                        name = "Movie Star",
                        model = "u_f_o_moviestar",
                        type = "PED",
                    },
                    {
                        name = "Prologue Hostage",
                        model = "u_f_o_prolhost_01",
                        type = "PED",
                    },
                    {
                        name = "Biker Chic",
                        model = "u_f_y_bikerchic",
                        type = "PED",
                    },
                    {
                        name = "Jane",
                        model = "u_f_y_comjane",
                        type = "PED",
                    },
                    {
                        name = "Corpse 2",
                        model = "u_f_y_corpse_01",
                        type = "PED",
                    },
                    {
                        name = "Corpse 3",
                        model = "u_f_y_corpse_02",
                        type = "PED",
                    },
                    {
                        name = "Posh Female",
                        model = "u_f_y_hotposh_01",
                        type = "PED",
                    },
                    {
                        name = "Jewel Store Assistant",
                        model = "u_f_y_jewelass_01",
                        type = "PED",
                    },
                    {
                        name = "Mistress",
                        model = "u_f_y_mistress",
                        type = "PED",
                    },
                    {
                        name = "Poppy Mitchell",
                        model = "u_f_y_poppymich",
                        type = "PED",
                    },
                    {
                        name = "Princess",
                        model = "u_f_y_princess",
                        type = "PED",
                    },
                    {
                        name = "Spy Actress",
                        model = "u_f_y_spyactress",
                        type = "PED",
                    },
                }
            },
            {
                name = "Story Scenario Males",
                is_folder = true,
                items = {
                    {
                        name = "Al Di Napoli",
                        model = "u_m_m_aldinapoli",
                        type = "PED",
                    },
                    {
                        name = "Bank Manager",
                        model = "u_m_m_bankman",
                        type = "PED",
                    },
                    {
                        name = "Bike Hire",
                        model = "u_m_m_bikehire_01",
                        type = "PED",
                    },
                    {
                        name = "DOA Agent",
                        model = "u_m_m_doa_01",
                        type = "PED",
                    },
                    {
                        name = "Eddie Toh",
                        model = "u_m_m_edtoh",
                        type = "PED",
                    },
                    {
                        name = "FIB Architect",
                        model = "u_m_m_fibarchitect",
                        type = "PED",
                    },
                    {
                        name = "Film Director",
                        model = "u_m_m_filmdirector",
                        type = "PED",
                    },
                    {
                        name = "Glen Stank",
                        model = "u_m_m_glenstank_01",
                        type = "PED",
                    },
                    {
                        name = "Griff",
                        model = "u_m_m_griff_01",
                        type = "PED",
                    },
                    {
                        name = "Jesus",
                        model = "u_m_m_jesus_01",
                        type = "PED",
                    },
                    {
                        name = "Jewelery Security",
                        model = "u_m_m_jewelsec_01",
                        type = "PED",
                    },
                    {
                        name = "Jewel Thief",
                        model = "u_m_m_jewelthief",
                        type = "PED",
                    },
                    {
                        name = "Mark Fostenburg",
                        model = "u_m_m_markfost",
                        type = "PED",
                    },
                    {
                        name = "Party Target",
                        model = "u_m_m_partytarget",
                        type = "PED",
                    },
                    {
                        name = "Prologue Security",
                        model = "u_m_m_prolsec_01",
                        type = "PED",
                    },
                    {
                        name = "Prologue Mourn Male",
                        model = "u_m_m_promourn_01",
                        type = "PED",
                    },
                    {
                        name = "Rival Paparazzo",
                        model = "u_m_m_rivalpap",
                        type = "PED",
                    },
                    {
                        name = "Spy Actor",
                        model = "u_m_m_spyactor",
                        type = "PED",
                    },
                    {
                        name = "Street Artist",
                        model = "u_m_m_streetart_01",
                        type = "PED",
                    },
                    {
                        name = "Love Fist Willy",
                        model = "u_m_m_willyfist",
                        type = "PED",
                    },
                    {
                        name = "Film Noir",
                        model = "u_m_o_filmnoir",
                        type = "PED",
                    },
                    {
                        name = "Financial Guru",
                        model = "u_m_o_finguru_01",
                        type = "PED",
                    },
                    {
                        name = "Tap Dancing Hillbilly",
                        model = "u_m_o_taphillbilly",
                        type = "PED",
                    },
                    {
                        name = "Old Male Tramp",
                        model = "u_m_o_tramp_01",
                        type = "PED",
                    },
                    {
                        name = "Abner",
                        model = "u_m_y_abner",
                        type = "PED",
                    },
                    {
                        name = "Anton Beaudelaire",
                        model = "u_m_y_antonb",
                        type = "PED",
                    },
                    {
                        name = "Baby D",
                        model = "u_m_y_babyd",
                        type = "PED",
                    },
                    {
                        name = "Baygor(kifflom)",
                        model = "u_m_y_baygor",
                        type = "PED",
                    },
                    {
                        name = "Burgershot Drug Dealer",
                        model = "u_m_y_burgerdrug_01",
                        type = "PED",
                    },
                    {
                        name = "Chip",
                        model = "u_m_y_chip",
                        type = "PED",
                    },
                    {
                        name = "Male Corpse 1",
                        model = "u_m_y_corpse_01",
                        type = "PED",
                    },
                    {
                        name = "Male Cyclist",
                        model = "u_m_y_cyclist_01",
                        type = "PED",
                    },
                    {
                        name = "FIB Mugger",
                        model = "u_m_y_fibmugger_01",
                        type = "PED",
                    },
                    {
                        name = "Guido",
                        model = "u_m_y_guido_01",
                        type = "PED",
                    },
                    {
                        name = "Gun Vendor",
                        model = "u_m_y_gunvend_01",
                        type = "PED",
                    },
                    {
                        name = "Hippie",
                        model = "u_m_y_hippie_01",
                        type = "PED",
                    },
                    {
                        name = "Impotent Rage",
                        model = "u_m_y_imporage",
                        type = "PED",
                    },
                    {
                        name = "Juggernaut",
                        model = "u_m_y_juggernaut_01",
                        type = "PED",
                    },
                    {
                        name = "Justin",
                        model = "u_m_y_justin",
                        type = "PED",
                    },
                    {
                        name = "Mani",
                        model = "u_m_y_mani",
                        type = "PED",
                    },
                    {
                        name = "Military Bum",
                        model = "u_m_y_militarybum",
                        type = "PED",
                    },
                    {
                        name = "Paparazzi",
                        model = "u_m_y_paparazzi",
                        type = "PED",
                    },
                    {
                        name = "Party",
                        model = "u_m_y_party_01",
                        type = "PED",
                    },
                    {
                        name = "Pogo",
                        model = "u_m_y_pogo_01",
                        type = "PED",
                    },
                    {
                        name = "Prisoner",
                        model = "u_m_y_prisoner_01",
                        type = "PED",
                    },
                    {
                        name = "Prologue Driver",
                        model = "u_m_y_proldriver_01",
                        type = "PED",
                    },
                    {
                        name = "Republican Space Ranger",
                        model = "u_m_y_rsranger_01",
                        type = "PED",
                    },
                    {
                        name = "Sports Bike Rider",
                        model = "u_m_y_sbike",
                        type = "PED",
                    },
                    {
                        name = "Hanger Mechanic",
                        model = "u_m_y_smugmech_01",
                        type = "PED",
                    },
                    {
                        name = "Groom Stag Party",
                        model = "u_m_y_staggrm_01",
                        type = "PED",
                    },
                    {
                        name = "Tattoo Artist",
                        model = "u_m_y_tattoo_01",
                        type = "PED",
                    },
                    {
                        name = "Yule Monster",
                        model = "U_M_M_YuleMonster",
                        type = "PED",
                    },
                    {
                        name = "Zombie",
                        model = "u_m_y_zombie_01",
                        type = "PED",
                    },
                }
            },
            {
                name = "DLC",
                is_folder = true,
                items = {
                    {
                        name = "Female Club Customer 1",
                        model = "a_f_y_clubcust_01",
                        type = "PED",
                    },
                    {
                        name = "Female Club Customer 2",
                        model = "a_f_y_clubcust_02",
                        type = "PED",
                    },
                    {
                        name = "Female Club Customer 3",
                        model = "a_f_y_clubcust_03",
                        type = "PED",
                    },
                    {
                        name = "Male Club Customer 1",
                        model = "a_m_y_clubcust_01",
                        type = "PED",
                    },
                    {
                        name = "Male Club Customer 2",
                        model = "a_m_y_clubcust_02",
                        type = "PED",
                    },
                    {
                        name = "Male Club Customer 3",
                        model = "a_m_y_clubcust_03",
                        type = "PED",
                    },
                    {
                        name = "Dixon",
                        model = "ig_dix",
                        type = "PED",
                    },
                    {
                        name = "DJ the Black Madonna",
                        model = "ig_djblamadon",
                        type = "PED",
                    },
                    {
                        name = "ig_djblamrupert",
                        model = "ig_djblamrupert",
                        type = "PED",
                    },
                    {
                        name = "ig_djblamryanh",
                        model = "ig_djblamryanh",
                        type = "PED",
                    },
                    {
                        name = "ig_djblamryans",
                        model = "ig_djblamryans",
                        type = "PED",
                    },
                    {
                        name = "Dixon Manager",
                        model = "ig_djdixmanager",
                        type = "PED",
                    },
                    {
                        name = "ig_djgeneric_01",
                        model = "ig_djgeneric_01",
                        type = "PED",
                    },
                    {
                        name = "ig_djsolfotios",
                        model = "ig_djsolfotios",
                        type = "PED",
                    },
                    {
                        name = "ig_djsoljakob",
                        model = "ig_djsoljakob",
                        type = "PED",
                    },
                    {
                        name = "DJ Solomun Manager",
                        model = "ig_djsolmanager",
                        type = "PED",
                    },
                    {
                        name = "ig_djsolmike",
                        model = "ig_djsolmike",
                        type = "PED",
                    },
                    {
                        name = "ig_djsolrobt",
                        model = "ig_djsolrobt",
                        type = "PED",
                    },
                    {
                        name = "ig_djtalaurelia",
                        model = "ig_djtalaurelia",
                        type = "PED",
                    },
                    {
                        name = "ig_djtalignazio",
                        model = "ig_djtalignazio",
                        type = "PED",
                    },
                    {
                        name = "English Dave",
                        model = "ig_englishdave",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Boston 2",
                        model = "ig_jimmyboston_02",
                        type = "PED",
                    },
                    {
                        name = "Kerry Mcintosh 2",
                        model = "ig_kerrymcintosh_02",
                        type = "PED",
                    },
                    {
                        name = "Lacey Jones 2",
                        model = "ig_lacey_jones_02",
                        type = "PED",
                    },
                    {
                        name = "Lazlow 2",
                        model = "ig_lazlow_2",
                        type = "PED",
                    },
                    {
                        name = "Solomun",
                        model = "ig_sol",
                        type = "PED",
                    },
                    {
                        name = "ig_talcc",
                        model = "ig_talcc",
                        type = "PED",
                    },
                    {
                        name = "ig_talmm",
                        model = "ig_talmm",
                        type = "PED",
                    },
                    {
                        name = "Tony Prince",
                        model = "ig_tonyprince",
                        type = "PED",
                    },
                    {
                        name = "Tyler Dix",
                        model = "ig_tylerdix_02",
                        type = "PED",
                    },
                    {
                        name = "Female Club Bar",
                        model = "s_f_y_clubbar_01",
                        type = "PED",
                    },
                    {
                        name = "Male Club Bar",
                        model = "s_m_y_clubbar_01",
                        type = "PED",
                    },
                    {
                        name = "Warehouse Tech",
                        model = "s_m_y_waretech_01",
                        type = "PED",
                    },
                    {
                        name = "Miranda 2",
                        model = "u_f_m_miranda_02",
                        type = "PED",
                    },
                    {
                        name = "u_f_y_danceburl_01",
                        model = "u_f_y_danceburl_01",
                        type = "PED",
                    },
                    {
                        name = "u_f_y_dancelthr_01",
                        model = "u_f_y_dancelthr_01",
                        type = "PED",
                    },
                    {
                        name = "u_f_y_dancerave_01",
                        model = "u_f_y_dancerave_01",
                        type = "PED",
                    },
                    {
                        name = "Poppy Mitchell",
                        model = "u_f_y_poppymich_02",
                        type = "PED",
                    },
                    {
                        name = "u_m_y_danceburl_01",
                        model = "u_m_y_danceburl_01",
                        type = "PED",
                    },
                    {
                        name = "u_m_y_dancelthr_01",
                        model = "u_m_y_dancelthr_01",
                        type = "PED",
                    },
                    {
                        name = "u_m_y_dancerave_01",
                        model = "u_m_y_dancerave_01",
                        type = "PED",
                    },
                    {
                        name = "Agatha",
                        model = "IG_Agatha",
                        type = "PED",
                    },
                    {
                        name = "Avery",
                        model = "IG_Avery",
                        type = "PED",
                    },
                    {
                        name = "Brucie 2",
                        model = "IG_Brucie2",
                        type = "PED",
                    },
                    {
                        name = "Tao Cheng 2",
                        model = "IG_TaoCheng2",
                        type = "PED",
                    },
                    {
                        name = "Taos Translator 2",
                        model = "IG_TaosTranslator2",
                        type = "PED",
                    },
                    {
                        name = "Thornton",
                        model = "IG_Thornton",
                        type = "PED",
                    },
                    {
                        name = "Tom Connors",
                        model = "IG_TomCasino",
                        type = "PED",
                    },
                    {
                        name = "Vincent",
                        model = "IG_Vincent",
                        type = "PED",
                    },
                    {
                        name = "Female General Casino",
                        model = "A_F_Y_GenCasPat_01",
                        type = "PED",
                    },
                    {
                        name = "Female Smart Casino",
                        model = "A_F_Y_SmartCasPat_01",
                        type = "PED",
                    },
                    {
                        name = "A_M_M_MLCrisis_01",
                        model = "A_M_M_MLCrisis_01",
                        type = "PED",
                    },
                    {
                        name = "Male General Casino",
                        model = "A_M_Y_GenCasPat_01",
                        type = "PED",
                    },
                    {
                        name = "Male Smart Casino",
                        model = "A_M_Y_SmartCasPat_01",
                        type = "PED",
                    },
                    {
                        name = "G_M_M_CasRN_01",
                        model = "G_M_M_CasRN_01",
                        type = "PED",
                    },
                    {
                        name = "S_M_Y_WestSec_01",
                        model = "S_M_Y_WestSec_01",
                        type = "PED",
                    },
                    {
                        name = "Female Casino",
                        model = "S_F_Y_Casino_01",
                        type = "PED",
                    },
                    {
                        name = "Male Casino",
                        model = "S_M_Y_Casino_01",
                        type = "PED",
                    },
                    {
                        name = "Carol",
                        model = "U_F_O_Carol",
                        type = "PED",
                    },
                    {
                        name = "Eileen",
                        model = "U_F_O_Eileen",
                        type = "PED",
                    },
                    {
                        name = "Casino Cashier",
                        model = "U_F_M_CasinoCash_01",
                        type = "PED",
                    },
                    {
                        name = "Casino Shop Clerk",
                        model = "U_F_M_CasinoShop_01",
                        type = "PED",
                    },
                    {
                        name = "Debbie",
                        model = "U_F_M_Debbie_01",
                        type = "PED",
                    },
                    {
                        name = "Beth",
                        model = "U_F_Y_Beth",
                        type = "PED",
                    },
                    {
                        name = "Lauren",
                        model = "U_F_Y_Lauren",
                        type = "PED",
                    },
                    {
                        name = "Taylor",
                        model = "U_F_Y_Taylor",
                        type = "PED",
                    },
                    {
                        name = "Blane",
                        model = "U_M_M_Blane",
                        type = "PED",
                    },
                    {
                        name = "Curtis",
                        model = "U_M_M_Curtis",
                        type = "PED",
                    },
                    {
                        name = "Vince",
                        model = "U_M_M_Vince",
                        type = "PED",
                    },
                    {
                        name = "Dean",
                        model = "U_M_O_Dean",
                        type = "PED",
                    },
                    {
                        name = "Caleb",
                        model = "U_M_Y_Caleb",
                        type = "PED",
                    },
                    {
                        name = "CroupThief_01",
                        model = "CroupThief_01",
                        type = "PED",
                    },
                    {
                        name = "Gabriel",
                        model = "U_M_Y_Gabriel",
                        type = "PED",
                    },
                    {
                        name = "Ushi",
                        model = "U_M_Y_Ushi",
                        type = "PED",
                    },
                    {
                        name = "a_f_y_bevhills_05",
                        model = "a_f_y_bevhills_05",
                        type = "PED",
                    },
                    {
                        name = "ig_celeb_01",
                        model = "ig_celeb_01",
                        type = "PED",
                    },
                    {
                        name = "Georgina Cheng",
                        model = "ig_georginacheng",
                        type = "PED",
                    },
                    {
                        name = "Huang",
                        model = "ig_huang",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Disanto 2",
                        model = "ig_jimmydisanto2",
                        type = "PED",
                    },
                    {
                        name = "Lester Crest 3",
                        model = "ig_lestercrest_3",
                        type = "PED",
                    },
                    {
                        name = "Vincent",
                        model = "ig_vincent_2",
                        type = "PED",
                    },
                    {
                        name = "Wendy",
                        model = "ig_wendy",
                        type = "PED",
                    },
                    {
                        name = "Highend Security 3",
                        model = "s_m_m_highsec_03",
                        type = "PED",
                    },
                    {
                        name = "West Security 2",
                        model = "s_m_y_westsec_02",
                        type = "PED",
                    },
                    {
                        name = "Female Beach 2",
                        model = "a_f_y_beach_02",
                        type = "PED",
                    },
                    {
                        name = "Club customer 3",
                        model = "a_f_y_clubcust_04",
                        type = "PED",
                    },
                    {
                        name = "Male Beach 1",
                        model = "a_m_o_beach_02",
                        type = "PED",
                    },
                    {
                        name = "Male Beach 2",
                        model = "a_m_y_beach_04",
                        type = "PED",
                    },
                    {
                        name = "Club Customer 4",
                        model = "a_m_y_clubcust_04",
                        type = "PED",
                    },
                    {
                        name = "Cartel Guards 1",
                        model = "g_m_m_cartelguards_01",
                        type = "PED",
                    },
                    {
                        name = "Cartel Guards 2",
                        model = "g_m_m_cartelguards_02",
                        type = "PED",
                    },
                    {
                        name = "Dre (better)",
                        model = "ig_ary",
                        type = "PED",
                    },
                    {
                        name = "English Dave 2",
                        model = "ig_englishdave_02",
                        type = "PED",
                    },
                    {
                        name = "Gustavo",
                        model = "ig_gustavo",
                        type = "PED",
                    },
                    {
                        name = "Helmsman Pavel",
                        model = "ig_helmsmanpavel",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_00",
                        model = "ig_isldj_00",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_01",
                        model = "ig_isldj_01",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_02",
                        model = "ig_isldj_02",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_03",
                        model = "ig_isldj_03",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_04",
                        model = "ig_isldj_04",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_04_d_01",
                        model = "ig_isldj_04_d_01",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_04_d_02",
                        model = "ig_isldj_04_d_02",
                        type = "PED",
                    },
                    {
                        name = "ig_isldj_04_e_01",
                        model = "ig_isldj_04_e_01",
                        type = "PED",
                    },
                    {
                        name = "Jackie",
                        model = "ig_jackie",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Iovine (better)",
                        model = "ig_jio",
                        type = "PED",
                    },
                    {
                        name = "Juan Strickler(El Rubio)",
                        model = "ig_juanstrickler",
                        type = "PED",
                    },
                    {
                        name = "Kaylee",
                        model = "ig_kaylee",
                        type = "PED",
                    },
                    {
                        name = "Miguel Madrazo",
                        model = "ig_miguelmadrazo",
                        type = "PED",
                    },
                    {
                        name = "DJ Pooh (better)",
                        model = "ig_mjo",
                        type = "PED",
                    },
                    {
                        name = "Old Rich Guy",
                        model = "ig_oldrichguy",
                        type = "PED",
                    },
                    {
                        name = "Patricia 2",
                        model = "ig_patricia_02",
                        type = "PED",
                    },
                    {
                        name = "Pilot",
                        model = "ig_pilot",
                        type = "PED",
                    },
                    {
                        name = "ig_sss",
                        model = "ig_sss",
                        type = "PED",
                    },
                    {
                        name = "Beach Bar Staff",
                        model = "s_f_y_beachbarstaff_01",
                        type = "PED",
                    },
                    {
                        name = "Female Club Bar 2",
                        model = "s_f_y_clubbar_02",
                        type = "PED",
                    },
                    {
                        name = "Bouncer 2",
                        model = "s_m_m_bouncer_02",
                        type = "PED",
                    },
                    {
                        name = "Drug Processor",
                        model = "s_m_m_drugprocess_01",
                        type = "PED",
                    },
                    {
                        name = "Fieldworker",
                        model = "s_m_m_fieldworker_01",
                        type = "PED",
                    },
                    {
                        name = "Highend Security 4",
                        model = "s_m_m_highsec_04",
                        type = "PED",
                    },
                    {
                        name = "Female Car Club 1",
                        model = "A_F_Y_CarClub_01",
                        type = "PED",
                    },
                    {
                        name = "Male Car Club 1",
                        model = "A_M_Y_CarClub_01",
                        type = "PED",
                    },
                    {
                        name = "Tattoo Customer",
                        model = "A_M_Y_TattooCust_01",
                        type = "PED",
                    },
                    {
                        name = "Prisoners 1",
                        model = "G_M_M_Prisoners_01",
                        type = "PED",
                    },
                    {
                        name = "Slasher 1",
                        model = "G_M_M_Slasher_01",
                        type = "PED",
                    },
                    {
                        name = "Avi Schwartzman 2",
                        model = "IG_AviSchwartzman_02",
                        type = "PED",
                    },
                    {
                        name = "Benny 2",
                        model = "IG_Benny_02",
                        type = "PED",
                    },
                    {
                        name = "Drug Dealer",
                        model = "IG_DrugDealer",
                        type = "PED",
                    },
                    {
                        name = "Hao 2",
                        model = "IG_Hao_02",
                        type = "PED",
                    },
                    {
                        name = "Lil Dee",
                        model = "IG_LilDee",
                        type = "PED",
                    },
                    {
                        name = "Mimi",
                        model = "IG_Mimi",
                        type = "PED",
                    },
                    {
                        name = "Moodyman 2",
                        model = "IG_Moodyman_02",
                        type = "PED",
                    },
                    {
                        name = "Sessanta",
                        model = "IG_Sessanta",
                        type = "PED",
                    },
                    {
                        name = "Female Autoshop 1",
                        model = "S_F_M_Autoshop_01",
                        type = "PED",
                    },
                    {
                        name = "Retail Staff",
                        model = "S_F_M_RetailStaff_01",
                        type = "PED",
                    },
                    {
                        name = "Male Autoshop 3",
                        model = "S_M_M_Autoshop_03",
                        type = "PED",
                    },
                    {
                        name = "Race Organizer 1",
                        model = "S_M_M_RaceOrg_01",
                        type = "PED",
                    },
                    {
                        name = "Tattoo Artist",
                        model = "S_M_M_Tattoo_01",
                        type = "PED",
                    },
                    {
                        name = "Female Studio Party 1",
                        model = "A_F_Y_StudioParty_01",
                        type = "PED",
                    },
                    {
                        name = "Female Studio Party 2",
                        model = "A_F_Y_StudioParty_02",
                        type = "PED",
                    },
                    {
                        name = "Male Studio Party 1",
                        model = "A_M_M_StudioParty_01",
                        type = "PED",
                    },
                    {
                        name = "Male Studio Party 2",
                        model = "A_M_Y_StudioParty_01",
                        type = "PED",
                    },
                    {
                        name = "Fooliganz",
                        model = "G_M_M_Fooliganz_01",
                        type = "PED",
                    },
                    {
                        name = "Friedlander Goons",
                        model = "G_M_M_FriedlanderGoons_01",
                        type = "PED",
                    },
                    {
                        name = "Goons 1",
                        model = "G_M_M_Goons_01",
                        type = "PED",
                    },
                    {
                        name = "Dre",
                        model = "IG_ARY_02",
                        type = "PED",
                    },
                    {
                        name = "Ballas Leader",
                        model = "IG_Ballas_Leader",
                        type = "PED",
                    },
                    {
                        name = "Billionaire",
                        model = "IG_Billionaire",
                        type = "PED",
                    },
                    {
                        name = "Entourage A",
                        model = "IG_Entourage_A",
                        type = "PED",
                    },
                    {
                        name = "Entourage B",
                        model = "IG_Entourage_B",
                        type = "PED",
                    },
                    {
                        name = "Golfer A",
                        model = "IG_Golfer_A",
                        type = "PED",
                    },
                    {
                        name = "Golfer B",
                        model = "IG_Golfer_B",
                        type = "PED",
                    },
                    {
                        name = "Imani",
                        model = "IG_Imani",
                        type = "PED",
                    },
                    {
                        name = "Jimmy Iovine",
                        model = "IG_JIO_02",
                        type = "PED",
                    },
                    {
                        name = "'Johnny Guns",
                        model = "IG_Johnny_Guns",
                        type = "PED",
                    },
                    {
                        name = "Lamar Davis 2",
                        model = "IG_LamarDavis_02",
                        type = "PED",
                    },
                    {
                        name = "DJ Pooh",
                        model = "IG_MJO_02",
                        type = "PED",
                    },
                    {
                        name = "Musician",
                        model = "IG_Musician_00",
                        type = "PED",
                    },
                    {
                        name = "Party Promoter",
                        model = "IG_Party_Promo",
                        type = "PED",
                    },
                    {
                        name = "Requisition Officer",
                        model = "IG_Req_Officer",
                        type = "PED",
                    },
                    {
                        name = "Security A",
                        model = "IG_Security_A",
                        type = "PED",
                    },
                    {
                        name = "Sound Engineer",
                        model = "IG_SoundEng_00",
                        type = "PED",
                    },
                    {
                        name = "Vagos Leader",
                        model = "IG_Vagos_Leader",
                        type = "PED",
                    },
                    {
                        name = "Vernon",
                        model = "IG_Vernon",
                        type = "PED",
                    },
                    {
                        name = "Vincent 3",
                        model = "IG_Vincent_3",
                        type = "PED",
                    },
                    {
                        name = "Franklin 2",
                        model = "P_Franklin_02",
                        type = "PED",
                    },
                    {
                        name = "Female Studio Assist",
                        model = "S_F_M_StudioAssist_01",
                        type = "PED",
                    },
                    {
                        name = "Highend Security",
                        model = "S_M_M_HighSec_05",
                        type = "PED",
                    },
                    {
                        name = "Male Studio Assist",
                        model = "S_M_M_StudioAssist_02",
                        type = "PED",
                    },
                    {
                        name = "Studio Producer",
                        model = "S_M_M_StudioProd_01",
                        type = "PED",
                    },
                    {
                        name = "Studio Sound Engineer",
                        model = "S_M_M_StudioSouEng_02",
                        type = "PED",
                    },
                    {
                        name = "Hazmat Worker",
                        model = "S_M_M_HazmatWorker_01",
                        type = "PED",
                    },

                }
            },
        },
    },
    {
        name = "Particle Effects",
        is_folder = true,
        items = {
            {
                name="Fire",
                type="PARTICLE",
                particle_attributes={
                    asset="core",
                    effect_name="fire_wrecked_plane_cockpit",
                }
            },
            {
                name="Smoke",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_as_trans",
                    effect_name="scr_as_trans_smoke",
                    color = {
                        r=100,
                        g=100,
                        b=100,
                        a=100,
                    }
                }
            },
            {
                name="Clown Appears",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcbarry2",
                    effect_name="scr_clown_appears",
                    scale=0.3,
                    loop_timer=500,
                }
            },
            {
                name="Alien Impact",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcbarry1",
                    effect_name="scr_alien_impact_bul",
                    scale=1,
                    loop_timer=50,
                },
            },
            {
                name="Blue Sparks",
                type="PARTICLE",
                particle_attributes={
                    asset="core",
                    effect_name="ent_dst_elec_fire_sp",
                    scale=1,
                    loop_timer=100,

                }
            },
            {
                name="Alien Disintegration",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcbarry1",
                    effect_name="scr_alien_disintegrate",
                    scale=0.1,
                    loop_timer=400,

                }
            },
            {
                name="Firey Particles",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcbarry1",
                    effect_name="scr_alien_teleport",
                    scale=0.1,
                    loop_timer=400,
                }
            },
            {
                name="Fireworks Burst",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_indep_fireworks",
                    effect_name="scr_indep_firework_shotburst",
                }
            },
            {
                name="Flare Smoke Trail",
                type="PARTICLE",
                particle_attributes={
                    asset="wpn_flare",
                    effect_name="proj_heist_flare_trail",
                }
            },
            {
                name="Flamethrower Loop",
                type="PARTICLE",
                particle_attributes={
                    asset="weap_xs_vehicle_weapons",
                    effect_name="muz_xs_turret_flamethrower_looping",
                }
            },
            {
                name="Flamethrower Loop #2",
                type="PARTICLE",
                particle_attributes={
                    asset="weap_xs_vehicle_weapons",
                    effect_name="muz_xs_turret_flamethrower_looping_sf",
                }
            },
            {
                name="Turbulent Water",
                type="PARTICLE",
                particle_attributes={
                    asset="weap_sm_tula",
                    effect_name="veh_tula_turbulance_water",
                }
            },
            {
                name="Railgun Charge",
                type="PARTICLE",
                particle_attributes={
                    asset="veh_khanjali",
                    effect_name="muz_xm_khanjali_railgun_charge",
                }
            },
            {
                name="Oil Jack Fire",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xs_props",
                    effect_name="scr_xs_oil_jack_fire",
                }
            },
            {
                name="Small Fire Pit",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xs_pits",
                    effect_name="scr_xs_fire_pit",
                }
            },
            {
                name="Large Fire Pit",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xs_pits",
                    effect_name="scr_xs_fire_pit_long",
                }
            },
            {
                name="Electric Pit",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xs_pits",
                    effect_name="scr_xs_sf_pit_long",
                }
            },
            {
                name="Large Electric Pit",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xs_pits",
                    effect_name="scr_xs_sf_pit",
                }
            },
            {
                name="Money Rain",
                type="PARTICLE",
                particle_attributes={
                    asset="xcr_xs_celebration",
                    effect_name="scr_xs_money_rain",
                }
            },
            {
                name="Money Rain Celebration",
                type="PARTICLE",
                particle_attributes={
                    asset="xcr_xs_celebration",
                    effect_name="scr_xs_money_rain_celeb",
                }
            },
            {
                name="Champagne Spray",
                type="PARTICLE",
                particle_attributes={
                    asset="xcr_xs_celebration",
                    effect_name="scr_xs_champagne_spray",
                }
            },
            {
                name="Stromberg Scanner",
                type="PARTICLE",
                particle_attributes={
                    asset="xcr_xm_submarine",
                    effect_name="scr_xm_stromberg_scanner",
                }
            },
            {
                name="Plane Smoke Trail",
                type="PARTICLE",
                particle_attributes={
                    asset="xcr_xm_spybomb",
                    effect_name="scr_xm_spybomb_plane_smoke_trail",
                }
            },
            {
                name="Package Flare",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xm_ht",
                    effect_name="scr_xm_ht_package_flare",
                }
            },
            {
                name="Electric Crackle",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xm_farm",
                    effect_name="scr_xm_dst_elec_cracke",
                }
            },
            {
                name="Heat Camo",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xm_heat",
                    effect_name="scr_xm_heat_camo",
                }
            },
            {
                name="Final Kill Thruster",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_xm_aq",
                    effect_name="scr_xm_aq_final_kill_thruster",
                }
            },
            {
                name="Weapon Highlight",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_sr_adversary",
                    effect_name="scr_sr_lg_weapon_highlight",
                }
            },
            {
                name="Recrash Rescue",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_recrash_rescue",
                    effect_name="scr_recrash_rescue",
                }
            },
            {
                name="Sparking Generator",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_reconstructionaccident",
                    effect_name="scr_sparking_generator",
                }
            },
            {
                name="Debris Trail",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcnigel2",
                    effect_name="scr_rcn2_debris_trail",
                }
            },
            {
                name="Alien Charging",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcbarry1",
                    effect_name="scr_alien_charging",
                }
            },
            {
                name="Alien Impact",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_rcbarry1",
                    effect_name="scr_alien_impact",
                }
            },
            {
                name="Fog Volume",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_jewelheist",
                    effect_name="scr_jewel_fog_volume",
                }
            },
            {
                name="Car Wash Jet",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_carwash",
                    effect_name="ent_amb_car_wash_jet",
                }
            },
            {
                name="Sauna Steam",
                type="PARTICLE",
                particle_attributes={
                    asset="cut_amb_tv",
                    effect_name="cs_amb_tv_sauna_steam",
                }
            },
            {
                name="Heli Wreck Fire",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_trevor2",
                    effect_name="scr_trev2_heli_wreck",
                }
            },
            {
                name="Fire Ring",
                type="PARTICLE",
                particle_attributes={
                    asset="scr_stunts",
                    effect_name="scr_stunts_fire_ring",
                }
            },
        },
    },
}

return curated_attachments
