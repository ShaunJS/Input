# Newbie Guide

---

*This guide was written by community member **Grace**. You can find her on [Twitter](https://twitter.com/gart_gh).*

&nbsp;

Hey there! Maybe you heard on the grapevine that the pug has some new tools for you to play with. Maybe you've tried to get this to work already, and missed one or two crucial details that were required to make it work. Well, fear no more because I'm about to show you the ropes. This guide assumes you have a pretty baseline level on how to use GMS, it won't be going into how to make any of the gamey bits, just how to make the input system start y'know, reading your input.

&nbsp;

## Step 1. Setup

To get this show on the road, first thing you're gonna want to do is to drag the [.yymps file](https://github.com/JujuAdams/Input/releases) you got into your project. A dialogue will pop up and you just gotta hit "add all" and then "OK". This will leave you with a new folder in your Asset Browser labeled "Input". That's good. You want that.

!> If you're using Input 5 on versions of GameMaker **before** 2022.5 (May 2022) then you'll need to call `input_tick()` in the Begin Step event of a persistent instance. This function handles all things Input behind the scenes, it is important to have [`input_tick()`](Functions-(System)#input_tick) once (and only once) each step of your game. A good way to do this is by making `obj_input_manager` [persistent](https://manual.yoyogames.com/#t=The_Asset_Editors%2FObjects.htm), and placing one instance in your first room.

&nbsp;

## Step 2: The Verb Zone

Now that the boring techy stuff is out of the way, we can get to the real fun and power of this input system. We're going to now be defining our verbs.

[Verbs](Verbs-and-Alternate-Bindings) are the basic input actions you want to expose to a player; this includes things like jumping, shooting, pausing the game, or moving in a particular direction. By using verbs we **abstract** user input so that we can change [input source](Input-Sources) while the game is played without needing to change anything else. Using verbs also allows for easier key rebinding.

Let's define some verbs then! To define default bindings for your verbs you'll need to edit the `INPUT_DEFAULT_PROFILES` macro found in `__input_config_profiles_and_bindings()`. When you import Input it'll come with some default controls already set up. To explain this clearer, let's delete everything that's already in `INPUT_DEFAULT_PROFILES` and start fresh. I'm going to define three controls, one for left, right, and shoot.

```gml
INPUT_DEFAULT_PROFILES = {
    
	//Bind keyboard controls to verbs
    keyboard_and_mouse:
    {
        left:  input_binding_key(vk_left),
        right: input_binding_key(vk_right),
        shoot: input_binding_key(ord("A")),
    },
}
```

We've got the [`input_binding_key()`](Functions-(Default-Bindings)#input_default_keykey-verb-alternate) functions taking the [normal key values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/Keyboard_Input/Keyboard_Input.htm) for the standard GM input features and then the verb we want to assign it to.

Here's a Step event for you to put in a character object or whatever!

```gml
//Move the player if the Left or Right verb is activated
if (input_check("left"))  x -= 4;
if (input_check("right")) x += 4;

//If the player pressed the "Shoot" button, fire a bullet
if (input_check_pressed("shoot")) show_debug_message("bang");
```

If you're at all familiar with how the standard GML input functions work, this should look pretty familiar to you. [`input_check()`](Functions-(Checkers)#input_checkverb-playerindex-bufferduration) is like [`keyboard_check()`](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/keyboard_check.html) and [`input_check_pressed()`](Functions-(Checkers)#input_check_pressedverb-playerindex-bufferduration) is like [`keyboard_check_pressed()`](https://docs2.yoyogames.com/source/_build/3_scripting/4_gml_reference/controls/keyboard%20input/keyboard_check_pressed.html).
Now, run the game and look at your hard work! Dang, aren't those inputs tasty? Ooh, looky here, buttons!

But by this point, you must be asking yourself "well grace, why didn't i just use `keyboard_check` functions and save myself all of this finagling?

Oh you sweet summer child, did you think we were done?

&nbsp;

## Step 3: Gamepad bindings

Lets go back to our create event for a hot sec.

Take a gander at this new code we'll add:

```gml
INPUT_DEFAULT_PROFILES = {
    
	//Bind keyboard controls to verbs
    keyboard_and_mouse:
    {
        left:  input_binding_key(vk_left),
        right: input_binding_key(vk_right),
        shoot: input_binding_key(ord("A")),
    },
	
	//Bind gamepad controls to verbs
	gamepad:
	{
	    left:  input_binding_gamepad_button(gp_padl),
	    right: input_binding_gamepad_button(gp_padr),
	    shoot: input_binding_gamepad_button(gp_face1),
	}
}
```

Just like the keyboard binding functions, gamepad binding functions use [normal gamepad input values](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Game_Input/GamePad_Input/Gamepad_Input.htm) from standard GM features. Congratulations, you now have gamepad input.

Input by default will start scanning for gamepad input when your game boots up; if the player uses the keyboard then Input will switch over to using the `keyboard_and_mouse` profile, if the player uses a gamepad then Input will switch over to using the `gamepad` profile (the names of these profiles can be controlled by changing some macros).

Et voilà! This system is also great for rebinding controls, handling multiplayer, and more. Take a deeper dive into the documentation for details on the features of Input, and feel free to [join us for discussion on Discord](https://discord.gg/8krYCqr).