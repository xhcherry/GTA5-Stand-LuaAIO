local Til = {
    '无',
    '礼车',
    '深色烟雾',
    '浅色烟雾',
    'STOCK',
    'LIMO',
    'GREEN'
}
local Lighc = {
    'White',
    'Blue',
    'Electric Blue',
    'Mint Green',
    'Lime Green',
    'Yellow',
    'Golden Shower',
    'Orange',
    'Red',
    'Pony Pink',
    'Hot Pink',
    'Purple',
    'Blacklight'

}
local Mainc = {
    'Metallic Black',
    'Metallic Graphite Black',
    'Metallic Black Steal',
    'Metallic Dark Silver',	
    'Metallic Silver',
    'Metallic Blue Silver',
    'Metallic Steel Gray',
    'Metallic Shadow Silver',
    'Metallic Stone Silver',
    'Metallic Midnight Silver',
    'Metallic Gun Metal',
    'Metallic Anthracite Grey',
    'Matte Black',
    'Matte Gray',
    'Matte Light Grey',	
    'Util Black',
    'Util Black Poly',
    'Util Dark silver',	
    'Util Silver',
    'Util Gun Metal',	
    'Util Shadow Silver',
    'Worn Black',
    'Worn Graphite',
    'Worn Silver Grey',	
    'Worn Silver',
    'Worn Blue Silver', 	
    'Worn Shadow Silver',	
    'Metallic Red',
    'Metallic Torino Red',
    'Metallic Formula Red',
    'Metallic Blaze Red', 	
    'Metallic Graceful Red',	
    'Metallic Garnet Red',
    'Metallic Desert Red',
    'Metallic Cabernet Red',
    'Metallic Candy Red',
    'Metallic Sunrise Orange',	
    'Metallic Classic Gold',
    'Metallic Orange',	
    'Matte Red', 	
    'Matte Dark Red',	
    'Matte Orange',
    'Matte Yellow',	
    'Util Red',
    'Util Bright Red',	
    'Util Garnet Red',	
    'Worn Red',
    'Worn Golden Red',
    'Worn Dark Red',
    'Metallic Dark Green',	
    'Metallic Racing Green',
    'Metallic Sea Green',	
    'Metallic Olive Green',	
    'Metallic Green',
    'Metallic Gasoline Blue Green',
    'Matte Lime Green',
    'Util Dark Green', 	
    'Util Green',
    'Worn Dark Green',	
    'Worn Green',
    'Worn Sea Wash',
    'Metallic Midnight Blue',	
    'Metallic Dark Blue',	
    'Metallic Saxony Blue',	
    'Metallic Blue',
    'Metallic Mariner Blue', 	
    'Metallic Harbor Blue', 	
    'Metallic Diamond Blue',	
    'Metallic Surf Blue',
    'Metallic Nautical Blue',	
    'Metallic Bright Blue',
    'Metallic Purple Blue',	
    'Metallic Spinnaker Blue', 	
    'Metallic Ultra Blue',	
    'Metallic Bright Blue',	
    'Util Dark Blue',
    'Util Midnight Blue', 	
    'Util Blue',
    'Util Sea Foam Blue',
    'Util Lightning blue',
    'Util Maui Blue Poly',
    'Util Bright Blue',
    'Matte Dark Blue',
    'Matte Blue',
    'Matte Midnight Blue',	
    'Worn Dark blue',
    'Worn Blue',
    'Worn Light blue',
    'Metallic Taxi Yellow',
    'Metallic Race Yellow',
    'Metallic Bronze',
    'Metallic Yellow Bird',
    'Metallic Lime',
    'Metallic Champagne',
    'Metallic Pueblo Beige',	
    'Metallic Dark Ivory',
    'Metallic Choco Brown',
    'Metallic Golden Brown',
    'Metallic Light Brown',
    'Metallic Straw Beige',	
    'Metallic Moss Brown',
    'Metallic Biston Brown',
    'Metallic Beechwood',
    'Metallic Dark Beechwood', 	
    'Metallic Choco Orange',	
    'Metallic Beach Sand',
    'Metallic Sun Bleeched Sand',	
    'Metallic Cream',
    'Util Brown',	
    'Util Medium Brown',	
    'Util Light Brown',	
    'Metallic White',	
    'Metallic Frost White',
    'Worn Honey Beige',
    'Worn Brown',	
    'Worn Dark Brown',
    'Worn straw beige',	
    'Brushed Steel',
    'Brushed Black steel', 	
    'Brushed Aluminium',
    'Chrome',
    'Worn Off White', 
    'Util Off White', 
    'Worn Orange', 
    'Worn Light Orange', 
    'Metallic Securicor Green',  	
    'Worn Taxi Yellow', 
    'police car blue',  	
    'Matte Green', 	
    'Matte Brown', 	
    'Worn Orange', 
    'Matte White', 	
    'Worn White',
    'Worn Olive Army Green', 	
    'Pure White',	
    'Hot Pink', 	
    'Salmon pink',
    'Metallic Vermillion Pink',
    'Orange',
    'Green',	
    'Blue',
    'Mettalic Black Blue', 	
    'Metallic Black Purple',	
    'Metallic Black Red',
    'Hunter Green',
    'Metallic Purple',
    'Metaillic V Dark Blue',	
    'MODSHOP BLACK1', 
    'Matte Purple',
    'Matte Dark Purple', 	
    'Metallic Lava Red',	
    'Matte Forest Green',	
    'Matte Olive Drab',	
    'Matte Desert Brown',
    'Matte Desert Tan', 	
    'Matte Foilage Green',
    'DEFAULT ALLOY COLOR',
    'Epsilon Blue',
    'Pure Gold',
    'Brushed Gold'
}

local Bbw = {
    'Chrome OG Hunnets',
    'Gold OG Hunnets',
    'Chrome Wires',
    'Gold Wires',
    'Chrome Spoked Out',
    'Gold Spoked Out',
    'Chrome Knock-Offs',
    'Gold Knock-Offs',
    'Chrome Bigger Worm',
    'Gold Bigger Worm',
    'Chrome Vintage Wire',
    'Gold Vintage Wire',
    'Chrome Classic Wire',
    'Gold Classic Wire',
    'GroundRide',
    'Chrome Smoothie',
    'Gold Smoothie',
    'Chrome Classic Rod',
    'Gold Classic Rod',
    'Chrome Dollar',
    'Gold Dollar',
    'Chrome Mighty Star',
    'Gold Mighty Star',
    'Chrome Decadent Dish',
    'Gold Decadent Dish',
    'Gold Razor Style',
    'Chrome Celtic Knot',
    'Gold Celtic Knot',
    'Chrome Warrior Dish',
    'Gold Warrior Dish',
    'Gold Big Dog Spokes',
    'Chrome OG Hunnets Thin White',
    'Gold OG Hunnets Thin White',
    'Chrome Wires Thin White',
    'Gold Wires Thin White',
    'Chrome Spoked Out Thin White',
    'Gold Spoked Out Thin White',
    'Chrome Knock-Offs Thin White',
    'Gold Knock-Offs Thin White',
    'Chrome Bigger Worm Thin White',
    'Gold Bigger Worm Thin White',
    'Chrome Vintage Wire Thin White',
    'Gold Vintage Wire Thin White',
    'Chrome Classic Wire Thin White',
    'Gold Classic Wire Thin White',
    'GroundRide Thin White',
    'Chrome Smoothie Thin White',
    'Gold Smoothie Thin White',
    'Chrome Classic Rod Thin White',
    'Gold Classic Rod Thin White',
    'Chrome Dollar Thin White',
    'Gold Dollar Thin White',
    'Chrome Mighty Star Thin White',
    'Gold Mighty Star Thin White',
    'Chrome Decadent Dish Thin White',
    'Gold Decadent Dish Thin White',
    'Gold Razor Style Thin White',
    'Chrome Celtic Knot Thin White',
    'Gold Celtic Knot Thin White',
    'Chrome Warrior Dish Thin White',
    'Gold Warrior Dish Thin White',
    'Gold Big Dog Spokes Thin White',
    'Chrome OG Hunnets Medium White',
    'Gold OG Hunnets Medium White',
    'Chrome Wires Medium White',
    'Gold Wires Medium White',
    'Chrome Spoked Out Medium White',
    'Gold Spoked Out Medium White',
    'Chrome Knock-Offs Medium White',
    'Gold Knock-Offs Medium White',
    'Chrome Bigger Worm Medium White',
    'Gold Bigger Worm Medium White',
    'Chrome Vintage Wire Medium White',
    'Gold Vintage Wire Medium White',
    'Chrome Classic Wire Medium White',
    'Gold Classic Wire Medium White',
    'GroundRide Medium White',
    'Chrome Smoothie Medium White',
    'Gold Smoothie Medium White',
    'Chrome Classic Rod Medium White',
    'Gold Classic Rod Medium White',
    'Chrome Dollar Medium White',
    'Gold Dollar Medium White',
    'Chrome Mighty Star Medium White',
    'Gold Mighty Star Medium White',
    'Chrome Decadent Dish Medium White',
    'Gold Decadent Dish Medium White',
    'Gold Razor Style Medium White',
    'Chrome Celtic Knot Medium White',
    'Gold Celtic Knot Medium White',
    'Chrome Warrior Dish Medium White',
    'Gold Warrior Dish Medium White',
    'Gold Big Dog Spokes Medium White',
    'Chrome OG Hunnets Thick White',
    'Gold OG Hunnets Thick White',
    'Chrome Wires Thick White',
    'Gold Wires Thick White',
    'Chrome Spoked Out Thick White',
    'Gold Spoked Out Thick White',
    'Chrome Knock-Offs Thick White',
    'Gold Knock-Offs Thick White',
    'Chrome Bigger Worm Thick White',
    'Gold Bigger Worm Thick White',
    'Chrome Vintage Wire Thick White',
    'Gold Vintage Wire Thick White',
    'Chrome Classic Wire Thick White',
    'Gold Classic Wire Thick White',
    'GroundRide Thick White',
    'Chrome Smoothie Thick White',
    'Gold Smoothie Thick White',
    'Chrome Classic Rod Thick White',
    'Gold Classic Rod Thick White',
    'Chrome Dollar Thick White',
    'Gold Dollar Thick White',
    'Chrome Mighty Star Thick White',
    'Gold Mighty Star Thick White',
    'Chrome Decadent Dish Thick White',
    'Gold Decadent Dish Thick White',
    'Gold Razor Style Thick White',
    'Chrome Celtic Knot Thick White',
    'Gold Celtic Knot Thick White',
    'Chrome Warrior Dish Thick White',
    'Gold Warrior Dish Thick White',
    'Gold Big Dog Spokes Thick White',
    'Chrome OG Hunnets Red Line',
    'Gold OG Hunnets Red Line',
    'Chrome Wires Red Line',
    'Gold Wires Red Line',
    'Chrome Spoked Out Red Line',
    'Gold Spoked Out Red Line',
    'Chrome Knock-Offs Red Line',
    'Gold Knock-Offs Red Line',
    'Chrome Bigger Worm Red Line',
    'Gold Bigger Worm Red Line',
    'Chrome Vintage Wire Red Line',
    'Gold Vintage Wire Red Line',
    'Chrome Classic Wire Red Line',
    'Gold Classic Wire Red Line',
    'GroundRide Red Line',
    'Chrome Smoothie Red Line',
    'Gold Smoothie Red Line',
    'Chrome Classic Rod Red Line',
    'Gold Classic Rod Red Line',
    'Chrome Dollar Red Line',
    'Gold Dollar Red Line',
    'Chrome Mighty Star Red Line',
    'Gold Mighty Star Red Line',
    'Chrome Decadent Dish Red Line',
    'Gold Decadent Dish Red Line',
    'Gold Razor Style Red Line',
    'Chrome Celtic Knot Red Line',
    'Gold Celtic Knot Red Line',
    'Chrome Warrior Dish Red Line',
    'Gold Warrior Dish Red Line',
    'Gold Big Dog Spokes Red Line',
    'Chrome OG Hunnets Blue Line',
    'Gold OG Hunnets Blue Line',
    'Chrome Wires Blue Line',
    'Gold Wires Blue Line',
    'Chrome Spoked Out Blue Line',
    'Gold Spoked Out Blue Line',
    'Chrome Knock-Offs Blue Line',
    'Gold Knock-Offs Blue Line',
    'Chrome Bigger Worm Blue Line',
    'Gold Bigger Worm Blue Line',
    'Chrome Vintage Wire Blue Line',
    'Gold Vintage Wire Blue Line',
    'Chrome Classic Wire Blue Line',
    'Gold Classic Wire Blue Line',
    'GroundRide Blue Line',
    'Chrome Smoothie Blue Line',
    'Gold Smoothie Blue Line',
    'Chrome Classic Rod Blue Line',
    'Gold Classic Rod Blue Line',
    'Chrome Dollar Blue Line',
    'Gold Dollar Blue Line',
    'Chrome Mighty Star Blue Line',
    'Gold Mighty Star Blue Line',
    'Chrome Decadent Dish Blue Line',
    'Gold Decadent Dish Blue Line',
    'Gold Razor Style Blue Line',
    'Chrome Celtic Knot Blue Line',
    'Gold Celtic Knot Blue Line',
    'Chrome Warrior Dish Blue Line',
    'Gold Warrior Dish Blue Line',
    'Gold Big Dog Spokes Blue Line',
}

local Bow = {
    'OG Hunnets',
    'OG Hunnets (Chrome Lip)',
    'Knock-Offs',
    'Knock-Offs (Chrome Lip)',
    'Spoked Out',
    'Spoked Out (Chrome Lip)',
    'Vintage Wire',
    'Vintage Wire (Chrome Lip)',
    'Smoothie',
    'Smoothie (Chrome Lip)',
    'Smoothie (Solid Color)',
    'Rod Me Up',
    'Rod Me Up (Chrome Lip)',
    'Rod Me Up (Solid Color)',
    'Clean',
    'Lotta Chrome',
    'Spindles',
    'Viking',
    'Triple Spoke',
    'Pharohe',
    'Tiger Style',
    'Three Wheelin',
    'Big Bar',
    'Biohazard',
    'Waves',
    'Lick Lick',
    'Spiralizer',
    'Hypnotics',
    'Psycho-Delic',
    'Half Cut',
    'Super Electric',
    'OG Hunnets Thin White',
    'OG Hunnets (Chrome Lip) Thin White',
    'Knock-Offs Thin White',
    'Knock-Offs (Chrome Lip) Thin White',
    'Spoked Out Thin White',
    'Spoked Out (Chrome Lip) Thin White',
    'Vintage Wire Thin White',
    'Vintage Wire (Chrome Lip) Thin White',
    'Smoothie Thin White',
    'Smoothie (Chrome Lip) Thin White',
    'Smoothie (Solid Color) Thin White',
    'Rod Me Up Thin White',
    'Rod Me Up (Chrome Lip) Thin White',
    'Rod Me Up (Solid Color) Thin White',
    'Clean Thin White',
    'Lotta Chrome Thin White',
    'Spindles Thin White',
    'Viking Thin White',
    'Triple Spoke Thin White',
    'Pharohe Thin White',
    'Tiger Style Thin White',
    'Three Wheelin Thin White',
    'Big Bar Thin White',
    'Biohazard Thin White',
    'Waves Thin White',
    'Lick Lick Thin White',
    'Spiralizer Thin White',
    'Hypnotics Thin White',
    'Psycho-Delic Thin White',
    'Half Cut Thin White',
    'Super Electric Thin White',
    'OG Hunnets Medium White',
    'OG Hunnets (Chrome Lip) Medium White',
    'Knock-Offs Medium White',
    'Knock-Offs (Chrome Lip) Medium White',
    'Spoked Out Medium White',
    'Spoked Out (Chrome Lip) Medium White',
    'Vintage Wire Medium White',
    'Vintage Wire (Chrome Lip) Medium White',
    'Smoothie Medium White',
    'Smoothie (Chrome Lip) Medium White',
    'Smoothie (Solid Color) Medium White',
    'Rod Me Up Medium White',
    'Rod Me Up (Chrome Lip) Medium White',
    'Rod Me Up (Solid Color) Medium White',
    'Clean Medium White',
    'Lotta Chrome Medium White',
    'Spindles Medium White',
    'Viking Medium White',
    'Triple Spoke Medium White',
    'Pharohe Medium White',
    'Tiger Style Medium White',
    'Three Wheelin Medium White',
    'Big Bar Medium White',
    'Biohazard Medium White',
    'Waves Medium White',
    'Lick Lick Medium White',
    'Spiralizer Medium White',
    'Hypnotics Medium White',
    'Psycho-Delic Medium White',
    'Half Cut Medium White',
    'Super Electric Medium White',
    'OG Hunnets Thick White',
    'OG Hunnets (Chrome Lip) Thick White',
    'Knock-Offs Thick White',
    'Knock-Offs (Chrome Lip) Thick White',
    'Spoked Out Thick White',
    'Spoked Out (Chrome Lip) Thick White',
    'Vintage Wire Thick White',
    'Vintage Wire (Chrome Lip) Thick White',
    'Smoothie Thick White',
    'Smoothie (Chrome Lip) Thick White',
    'Smoothie (Solid Color) Thick White',
    'Rod Me Up Thick White',
    'Rod Me Up (Chrome Lip) Thick White',
    'Rod Me Up (Solid Color) Thick White',
    'Clean Thick White',
    'Lotta Chrome Thick White',
    'Spindles Thick White',
    'Viking Thick White',
    'Triple Spoke Thick White',
    'Pharohe Thick White',
    'Tiger Style Thick White',
    'Three Wheelin Thick White',
    'Big Bar Thick White',
    'Biohazard Thick White',
    'Waves Thick White',
    'Lick Lick Thick White',
    'Spiralizer Thick White',
    'Hypnotics Thick White',
    'Psycho-Delic Thick White',
    'Half Cut Thick White',
    'Super Electric Thick White',
    'OG Hunnets Red Line',
    'OG Hunnets (Chrome Lip) Red Line',
    'Knock-Offs Red Line',
    'Knock-Offs (Chrome Lip) Red Line',
    'Spoked Out Red Line',
    'Spoked Out (Chrome Lip) Red Line',
    'Vintage Wire Red Line',
    'Vintage Wire (Chrome Lip) Red Line',
    'Smoothie Red Line',
    'Smoothie (Chrome Lip) Red Line',
    'Smoothie (Solid Color) Red Line',
    'Rod Me Up Red Line',
    'Rod Me Up (Chrome Lip) Red Line',
    'Rod Me Up (Solid Color) Red Line',
    'Clean Red Line',
    'Lotta Chrome Red Line',
    'Spindles Red Line',
    'Viking Red Line',
    'Triple Spoke Red Line',
    'Pharohe Red Line',
    'Tiger Style Red Line',
    'Three Wheelin Red Line',
    'Big Bar Red Line',
    'Biohazard Red Line',
    'Waves Red Line',
    'Lick Lick Red Line',
    'Spiralizer Red Line',
    'Hypnotics Red Line',
    'Psycho-Delic Red Line',
    'Half Cut Red Line',
    'Super Electric Red Line',
    'OG Hunnets Blue Line',
    'OG Hunnets (Chrome Lip) Blue Line',
    'Knock-Offs Blue Line',
    'Knock-Offs (Chrome Lip) Blue Line',
    'Spoked Out Blue Line',
    'Spoked Out (Chrome Lip) Blue Line',
    'Vintage Wire Blue Line',
    'Vintage Wire (Chrome Lip) Blue Line',
    'Smoothie Blue Line',
    'Smoothie (Chrome Lip) Blue Line',
    'Smoothie (Solid Color) Blue Line',
    'Rod Me Up Blue Line',
    'Rod Me Up (Chrome Lip) Blue Line',
    'Rod Me Up (Solid Color) Blue Line',
    'Clean Blue Line',
    'Lotta Chrome Blue Line',
    'Spindles Blue Line',
    'Viking Blue Line',
    'Triple Spoke Blue Line',
    'Pharohe Blue Line',
    'Tiger Style Blue Line',
    'Three Wheelin Blue Line',
    'Big Bar Blue Line',
    'Biohazard Blue Line',
    'Waves Blue Line',
    'Lick Lick Blue Line',
    'Spiralizer Blue Line',
    'Hypnotics Blue Line',
    'Psycho-Delic Blue Line',
    'Half Cut Blue Line',
    'Super Electric Blue Line',
}
local Bw = {
    'Speedway',
    'Street Special',
    'Racer',
    'Track Star',
    'Overlord',
    'Trident',
    'Triple Threat',
    'Stilleto',
    'Wires',
    'Bobber',
    'Solidus',
    'Ice Shield',
    'Loops',
    'Chrome Speedway',
    'Chrome Street Special',
    'Chrome Racer',
    'Chrome Track Star',
    'Chrome Overlord',
    'Chrome Trident',
    'Chrome Triple Threat',
    'Chrome Stilleto',
    'Chrome Wires',
    'Chrome Bobber',
    'Chrome Solidus',
    'Chrome Ice Shield',
    'Chrome Loops',
    'Romper Racing',
    'Warp Drive',
    'Snowflake',
    'Holy Spoke',
    'Old Skool Triple',
    'Futura',
    'Quarter Mile King',
    'Cartwheel',
    'Double Five',
    'Shuriken',
    'Simple Six',
    'Celtic',
    'Razer',
    'Twisted',
    'Morning Star',
    'Jagged Spokes',
    'Eidolon',
    'Enigma',
    'Big Spokes',
    'Webs',
    'Hotplate',
    'Bobsta',
    'Grouch',
}

local Hew = {
    'Shadow',
    'Hyper',
    'Blade',
    'Diamond',
    'Supa Gee',
    'Chromatic Z ',
    'Mercie Ch.Lip',
    'Obey RS',
    'GT Chrome',
    'Cheetah R',
    'Solar',
    'Split Ten',
    'Dash VIP',
    'LozSpeed Ten',
    'Carbon Inferno',
    'Carbon Shadow',
    'Carbonic Z',
    'Carbon Solar',
    'Cheetah Carbon R',
    'Carbon S Racer',
    'Chrome Shadow',
    'Chrome Hyper',
    'Chrome Blade',
    'Chrome Diamond',
    'Chrome Supa Gee',
    'Chrome Chromatic Z ',
    'Chrome Mercie Ch.Lip',
    'Chrome Obey RS',
    'Chrome GT Chrome',
    'Chrome Cheetah R',
    'Chrome Solar',
    'Chrome Split Ten',
    'Chrome Dash VIP',
    'Chrome LozSpeed Ten',
    'Chrome Carbon Inferno',
    'Chrome Carbon Shadow',
    'Chrome Carbonic Z',
    'Chrome Carbon Solar',
    'Chrome Cheetah Carbon R',
    'Chrome Carbon S Racer',
}
 
local Lw = {
    'Flares',
    'Wired',
    'Triple Golds',
    'Big Worm',
    'Seven Fives',
    'Split Six',
    'Fresh Mesh',
    'Lead Sled',
    'Turbine',
    'Super Fin',
    'Classic Rod',
    'Dollar',
    'Dukes',
    'Low Five',
    'Gooch',
    'Chrome Flare',
    'Chrome Wired',
    'Chrome Triple Golds',
    'Chrome Big Worm',
    'Chrome Seven Fives',
    'Chrome Split Six',
    'Chrome Fresh Mesh',
    'Chrome Lead Sled',
    'Chrome Turbine',
    'Chrome Super Fin',
    'Chrome Classic Rod',
    'Chrome Dollar',
    'Chrome Dukes',
    'Chrome Low Five',
    'Chrome Gooch',
}
 
local Mw = {
    'Classic Five',
    'Dukes',
    'Muscle Freak',
    'Kracka',
    'Azreal',
    'Mecha',
    'Black Top',
    'Drag SPL',
    'Revolver',
    'Classic Rod ',
    'Fairlie',
    'Spooner',
    'Five Star',
    'Old School',
    'El Jefe',
    'Dodman',
    'Six Gun',
    'Mercenary',
    'Chrome Classic Five',
    'Chrome Dukes',
    'Chrome Muscle Freak',
    'Chrome Kracka',
    'Chrome Azreal',
    'Chrome Mecha',
    'Chrome Black Top',
    'Chrome Drag SPL',
    'Chrome Revolver',
    'Chrome Classic Rod ',
    'Chrome Fairlie',
    'Chrome Spooner',
    'Chrome Five Star',
    'Chrome Old School',
    'Chrome El Jefe',
    'Chrome Dodman',
    'Chrome Six Gun',
    'Chrome Mercenary',

}
 
local Orw = {
    'Raider',
    'Mudslinger',
    'Nevis',
    'Cairngorm',
    'Amazon',
    'Challenger',
    'Dune Basher',
    'Five Star',
    'Rock Crawler',
    'Mill Spec Steelie',
    'Chrome Raider',
    'Chrome Mudslinger',
    'Chrome Nevis',
    'Chrome Cairngorm',
    'Chrome Amazon',
    'Chrome Challenger',
    'Chrome Dune Basher',
    'Chrome Five Star',
    'Chrome Rock Crawler',
    'Chrome Mill Spec Steelie',
    'Retro Steelie',
    'Heavy Duty Steelie',
    'Concave Steelie',
    'Police Issue Steelie',
    'Lightweight Steelie',
    'Dukes',
    'Avalanche',
    'Mountain Man',
    'Rigde Climber',
    'Concave 5',
    'Flat Six',
    'All Terrain Monster',
    'Drag SPL',
    'Concave Rally Master',
    'Rugged Snowflake',
}
 
local Rw = {
    'Classic 5',
    'Classic 5 (Striped)',
    'Retro Star',
    'Retro Star (Striped)',
    'Triplex',
    'Triplex (Striped)',
    '70s Spec',
    '70s Spec (Striped)',
    'Super 5R',
    'Super 5R (Striped)',
    'Speedster',
    'Speedster (Striped)',
    'GP-90',
    'GP-90 (Striped)',
    'Superspoke',
    'Superspoke (Striped)',
    'Gridline',
    'Gridline (Striped)',
    'Snowflake',
    'Snowflake (Striped)',
}
 
local Spw = {
    'Inferno',
    'Deep Five',
    'Lozspeed Mk.V',
    'Diamond Cut',
    'Chrono',
    'Feroci RR',
    'FiftyNine',
    'Mercie',
    'Synthetic Z',
    'Organic Type 0',
    'Endo v.1',
    'GT One',
    'Duper 7',
    'Uzer',
    'GroundRide',
    'S Racer',
    'Venum',
    'Cosmo',
    'Dash VIP',
    'Ice Kid',
    'Ruff Weld',
    'Wangan Master',
    'Super Five',
    'Endo v.2',
    'Split Six',
    'Chrome Inferno',
    'Chrome Deep Five',
    'Chrome Lozspeed Mk.V',
    'Chrome Diamond Cut',
    'Chrome Chrono',
    'Chrome Feroci RR',
    'Chrome FiftyNine',
    'Chrome Mercie',
    'Chrome Synthetic Z',
    'Chrome Organic Type 0',
    'Chrome Endo v.1',
    'Chrome GT One',
    'Chrome Duper 7',
    'Chrome Uzer',
    'Chrome GroundRide',
    'Chrome S Racer',
    'Chrome Venum',
    'Chrome Cosmo',
    'Chrome Dash VIP',
    'Chrome Ice Kid',
    'Chrome Ruff Weld',
    'Chrome Wangan Master',
    'Chrome Super Five',
    'Chrome Endo v.2',
    'Chrome Split Six',
}

local Stw = {
    'Retro Steelie',
    'Poverty Spec Steelie',
    'Concave Steelie',
    'Nebula',
    'Hotring Steelie',
    'Cup Champion',
    'Stanced EG Custom',
    'Kracka Custom',
    'Dukes Custom',
    'Endo v.3 Custom',
    'V8 Killer',
    'Fujiwara Custom',
    'Cosmo MKII',
    'Aero Star',
    'Hype Five',
    'Ruff Weld Mega Deep ',
    'Mercie Concave',
    'Sugoi Concave',
    'Synthetic Z Concave',
    'Endo v.4 Dished',
    'Hyperfresh',
    'Truffade Concave',
    'Organic Type II',
    'Big Mamba',
    'Deep Flake',
    'Cosmo MKIII',
    'Concave Racer',
    'Deep Flake Reverse',
    'Wild Wagon',
    'Concave Mega Mesh',
}

local Suw = {
    'VIP',
    'Benefactor',
    'Cosmo',
    'Bippu',
    'Royal Six ',
    'Fagorme',
    'Deluxe',
    'Iced Out',
    'Cognoscenti',
    'LozSpeed Ten',
    'Supernova',
    'Obey RS',
    'LozSpeed Baller',
    'Extravaganzo',
    'Split Six',
    'Empowered',
    'Sunrise',
    'Dash VIP',
    'Cutter',
    'Chrome VIP',
    'Chrome Benefactor',
    'Chrome Cosmo',
    'Chrome Bippu',
    'Chrome Royal Six ',
    'Chrome Fagorme',
    'Chrome Deluxe',
    'Chrome Iced Out',
    'Chrome Cognoscenti',
    'Chrome LozSpeed Ten',
    'Chrome Supernova',
    'Chrome Obey RS',
    'Chrome LozSpeed Baller',
    'Chrome Extravaganzo',
    'Chrome Split Six',
    'Chrome Empowered',
    'Chrome Sunrise',
    'Chrome Dash VIP',
    'Chrome Cutter',
}

local Trw = {
    'Rally Throwback',
    'Gravel Trap',
    'Stove Top',
    'Stove Top Mesh',
    'Retro 3 Piece',
    'Rally Monoblock',
    'Forged 5',
    'Split Star',
    'Speed Boy',
    '90s Running',
    'Tropos',
    'Exos',
    'High Five',
    'Super Luxe',
    'Pure Business',
    'Pepper Pot',
    'Blacktop Blender',
    'Throwback',
    'Expressway',
    'Hidden Six',
    'Dinka SPL',
    'Retro Turbofan',
    'Conical Turbofan',
    'Ice Storm',
    'Super Turbine',
    'Modern Mesh',
    'Forged Star',
    'Snowflake',
    'Giga Mesh',
    'Mesh Meister',
}

local Tuw = {
    'Cosmo',
    'Super Mesh',
    'Outsider',
    'Rollas',
    'Driftmeister',
    'Slicer',
    'El Quatro',
    'Dubbed',
    'Five Star',
    'Slideways',
    'Apex',
    'Stanced EG',
    'Countersteer',
    'Endo v.1',
    'Endo v.2 Dish',
    'Gruppe Z',
    'Choku-Dori',
     'Chicane',
    'Saisoku',
    'Dished Eight',
    'Fujiwara',
    'Zokusha',
    'Battle VIII',
    'Rally Master',
    'Chrome Cosmo',
    'Chrome Super Mesh',
    'Chrome Outsider',
    'Chrome Rollas',
    'Chrome Driftmeister',
    'Chrome Slicer',
    'Chrome El Quatro',
    'Chrome Dubbed',
    'Chrome Five Star',
    'Chrome Slideways',
    'Chrome Apex',
    'Chrome Stanced EG',
    'Chrome Countersteer',
    'Chrome Endo v.1',
    'Chrome Endo v.2 Dish',
    'Chrome Gruppe Z',
    'Chrome Choku-Dori',
    'Chrome Chicane',
    'Chrome Saisoku',
    'Chrome Dished Eight',
    'Chrome Fujiwara',
    'Chrome Zokusha',
    'Chrome Battle VIII',
    'Chrome Rally Master',
}
local Vehopts = { 
    {1 , "尾翼"},
    {2 , "前保险杠"},
    {3 , "后保险杠"},
    {4 , "侧裙"},
    {5 , "排气管"},
    {6 , "防滚架"},
    {7 , "中网/百叶窗/反制系统"},
    {8 , "引擎盖"},
    {9 , "左翼子板"},
    {10 , "右翼子板/地理"},
    {11 , "车顶/武器"},
    {12 , "引擎"},
    {13 , "刹车"},
    {14 , "变速箱"},
    {15 , "喇叭"},
    {16 , "悬挂系统"},
    {17 , "防御"},
    {24 , "车轮"},
    {25 , "摩托后轮设计"},
    {26 , "钢板固定器"},
    {28 , "内饰设计"},
    {29 , "装饰品"},
    {31 , "表盘设计"},
    {34 , "方向盘"},
    {35 , "Shifter Leavers"},
    {36 , "Plaques"},
    {39 , "液压"},
    {49 , "涂装"},
}

local Vehtogs = {
    {19 , "涡轮增压"},
    {21 , "轮胎烟雾"},
    {23 , "大灯"},
}






    


---本地函数库
local function Getmodcou(pid, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    if not players.exists(pid) then
        return
    end
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local max = VEHICLE.GET_NUM_VEHICLE_MODS(vmod, mod)
        return max
    end
end
local function Changemod(pid, modtype, mod)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
    if PED.IS_PED_IN_ANY_VEHICLE(pedm) ==true then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
            request_control(vmod)
        VEHICLE.GET_NUM_MOD_KITS(vmod)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, modtype, mod, false)
    end
end
local function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end
local function Changewheel(pid, wtype, wheel)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local vhash = ENTITY.GET_ENTITY_MODEL(vmod)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    if VEHICLE.IS_THIS_MODEL_A_BIKE(vhash) then
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, wtype)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, wheel)
        VEHICLE.SET_VEHICLE_MOD(vmod, 24, wheel)
    else
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, wtype)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, wheel)
    end
end
local function Changehead(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color)
end
local function Changeneon(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    RGBNeonKit(pedm)
    VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color)
end
local function Changetint(pid, tint)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vmod, tint)
end
local function Changecolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, color.prim, color.sec)
end
local function Changewhepercolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, color.per, color.whe)
end
local function Changeintcolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color)
end
local function Changedashcolor(pid, color)
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, true)
    local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Nuts Method"))
    if not players.exists(pid) then
        return
    end
        request_control(vmod)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(vmod, color)
end












----主menu
local pbodym = menu.list(workshop, '固定外观', {}, '')
local plighm = menu.list(workshop, '车辆灯光', {}, '')
local pcolm  = menu.list(workshop, '车辆颜色', {}, '')
local pwmenu = menu.list(workshop, '车轮', {}, '')

local vehmenu = {}
menu.on_focus(pbodym, function ()
    for _, m in ipairs(vehmenu) do
        menu.delete(m)
    end
    vehmenu = {}
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    if PED.IS_PED_IN_ANY_VEHICLE(pedm, false) then
        for _, v in pairs(Vehopts) do
            local current = VEHICLE.GET_VEHICLE_MOD(vmod, v[1] -1)
            local maxmods = Getmodcou(players.user(), v[1] - 1)
            if maxmods > 0  then
                local modnames = v[2]
                local s = menu.slider(pbodym, modnames , {''}, '',  -1, maxmods  , current, 1, function (mod)
                    Changemod(players.user(), v[1] -1, mod)
                end)
              table.insert(vehmenu, s)
            util.yield()
            end
        end

          for i, v in pairs(Vehtogs) do
            local current = VEHICLE.IS_TOGGLE_MOD_ON(vmod, v[1] -1)
            local tognames = v[2]
            local t = menu.toggle(pbodym, tognames, {''}, '', function (on)
                VEHICLE.TOGGLE_VEHICLE_MOD(vmod, v[1] - 1, on)
              end, current)         
            table.insert(vehmenu, t)
          util.yield()
        end
    end
end)

local pcolor = {}
menu.list_select(pcolm, '主色调', {''}, '更改车辆的原色', Mainc, 1, function (t)
    pcolor.prim = t - 1
    Changecolor(players.user(), pcolor)
end)
menu.list_select(pcolm, '副色调', {''}, '更改车辆的次要颜色', Mainc, 1, function (t)
    pcolor.sec = t - 1
    Changecolor(players.user(), pcolor)
end)
menu.list_select(pcolm, '珠光色', {''}, '更改载具上的珠光颜色', Mainc, 1, function (t)
    pcolor.per = t - 1
    Changewhepercolor(players.user(), pcolor)
end)

menu.list_select(pcolm, '车轮颜色', {''}, '更改车辆上的车轮颜色', Mainc, 1, function (t)
    pcolor.whe = t - 1
    Changewhepercolor(players.user(), pcolor)
end)
menu.list_select(pcolm, '内饰颜色', {''}, '更改车辆的内部颜色', Mainc, 1, function (t)
    pcolor.int = t - 1
    Changeintcolor(players.user(), pcolor.int)
end)
menu.list_select(pcolm, '仪表板颜色', {''}, '更改车辆上的仪表板颜色', Mainc, 1, function (t)
    pcolor.das = t - 1
    Changedashcolor(players.user(), pcolor.das)
end)
menu.list_select(plighm, '霓虹灯', {''}, '将霓虹灯更改为不同的颜色', Mainc, 1, function(c)
    local ncolor = c - 1
    Changeneon(players.user(), ncolor)
end)
menu.list_select(workshop, '窗口色调', {''}, '改变车辆的色调', Til, 1, function (t)
    local tint = t - 1
    Changetint(players.user(), tint)
end)
menu.list_select(plighm, '车辆大灯', {''}, '将大灯更改为不同的颜色', Lighc, 1, function(c)
    local hcolor = c - 1
    Changehead(players.user(), hcolor)
end)

local pnrgb = {color= {r= 0, g = 1, b = 0, a = 1}}
menu.action(plighm, '改变 RGB 霓虹灯', {}, '将霓虹灯的颜色更改为您选择的 RGB', function ()
    local pedm = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    RGBNeonKit(pedm)
    local red = pnrgb.color.r * 255
    local green = pnrgb.color.g * 255
    local blue = pnrgb.color.b * 255
    VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
end)
menu.colour(plighm, 'RGB 霓虹色', {'rgbsc'}, '选择霓虹灯的颜色更改为', pnrgb.color, false, function(ncolor)
    pnrgb.color = ncolor
end)


local pwmenu_style = menu.list(pwmenu, '车轮样式', {}, '')
    menu.list_select(pwmenu_style, '本尼斯定制', {''}, '将车轮更换为 Bennys Bespoke 车轮', Bbw, 1, function(w)
        local wheel = w - 1
        Changewheel(players.user(), 9, wheel)
    end)
    menu.list_select(pwmenu_style, '本尼原件', {''}, '将车轮更换为 Bennys Originals 车轮', Bow, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 8, wheel)
    end)
    menu.list_select(pwmenu_style, '自行车', {''}, '将车轮改为自行车（摩托车）车轮', Bw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 6, wheel)
    end)
    menu.list_select(pwmenu_style, '高端', {''}, '将车轮更改为高端车轮', Hew, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 7, wheel)
    end)
    menu.list_select(pwmenu_style, '低骑者', {''}, '将车轮更改为 Lowrider 车轮', Lw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 2, wheel)
        
    end)
    menu.list_select(pwmenu_style, '肌肉', {''}, '将轮子改为肌肉轮', Mw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 1, wheel)
    end)
    menu.list_select(pwmenu_style, '越野', {''}, '将车轮更改为越野车轮', Orw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 4, wheel)
    end)
    menu.list_select(pwmenu_style, '赛车（一级方程式车轮）', {''}, '将车轮更改为赛车（一级方程式车轮）车轮', Rw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 10, wheel)
    end)
    menu.list_select(pwmenu_style, '运动', {''}, '将车轮更改为运动车轮', Spw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 0, wheel)
    end)
    menu.list_select(pwmenu_style, '街道', {''}, '将车轮更改为街道车轮', Stw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 11, wheel)
    end)
    menu.list_select(pwmenu_style, '越野车', {''}, '将车轮改为 SUV 车轮', Suw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 3, wheel)
    end)
    menu.list_select(pwmenu_style, '曲目', {''}, '将轮子更改为履带轮', Trw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 12, wheel)
    end)
    menu.list_select(pwmenu_style, '调谐器', {''}, '将车轮更改为调谐器车轮', Tuw, 1,function(w)
        local wheel = w - 1
        Changewheel(players.user(), 5, wheel)
    end)
menu.toggle(pwmenu, "防弹轮胎", {}, "", function(toggled)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not toggled)
end)