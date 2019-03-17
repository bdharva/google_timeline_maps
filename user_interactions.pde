void keyPressed() {
 
  if (keyCode == LEFT) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("nav")) {
    
        view_index = view_index > 0 ? view_index - 1 : config_values.getJSONObject(state).size() - 1;
        view = get_view_values();

      } else if (mode.equals("edit")) {

        field_index = field_index > 0 ? field_index - 1 : field_lookup.length - 1;

        while (!boolean(editable_lookup[field_index])) {
        
          field_index = field_index > 0 ? field_index - 1 : field_lookup.length - 1;

        }

      }

    } else if (state.equals("map")) {

      view.setString("longitude", str(view.getFloat("longitude") - step));
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config_values, "data/config/values.json");
      
    }

  } else if (keyCode == RIGHT) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("nav")) {
    
        view_index = view_index < (config_values.getJSONObject(state).size() - 1) ? view_index + 1 : 0;
        view = get_view_values();

      } else if (mode.equals("edit")) {

        field_index = field_index < (field_lookup.length - 1) ? field_index + 1 : 0;

        while (!boolean(editable_lookup[field_index])) {

          field_index = field_index < (field_lookup.length - 1) ? field_index + 1 : 0;

        }

      }

    } else if (state.equals("map")) {

      view.setString("longitude", str(view.getFloat("longitude") + step));
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config_values, "data/config/values.json");

    }

  } else if (keyCode == UP) {

    if (state.equals("map")) {

      view.setString("latitude", str(view.getFloat("latitude") + step));
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config_values, "data/config/values.json");

    }

  } else if (keyCode == DOWN) {

    if (state.equals("map")) {

      view.setString("latitude", str(view.getFloat("latitude") - step));
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config_values, "data/config/values.json");
      
    }

  } else if ((key == '_' || key == '-') && state.equals("map")) {

    if (state.equals("map") && view.getInt("zoom") > 3) {

      view.setString("zoom", str(view.getInt("zoom") - 1));
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config_values, "data/config/values.json");
      
    }

  } else if ((key == '+' || key == '=') && state.equals("map")) {

    if (state.equals("map") && view.getInt("zoom") < 18) {

      view.setString("zoom", str(view.getInt("zoom") + 1));
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config_values, "data/config/values.json");
      
    }

  } else if (keyCode == ENTER) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("nav")) {

        mode = "edit";
        field_index = 0;

        while (!boolean(editable_lookup[field_index])) {

          field_index = field_index < (field_lookup.length - 1) ? field_index + 1 : 0;

        }

      } else if (mode.equals("edit")) {

        implement_user_settings();
        saveJSONObject(config_values, "data/config/values.json");
        mode = "nav";

      } 

    }

  } else if (keyCode == BACKSPACE) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("edit")) {

        String edit = get_field();
        
        if (edit.length() > 0) {

          set_field(edit.substring(0, edit.length()-1));

        }

      } 

    }

  } else if (keyCode == DELETE) {

    set_field("");

  } else if ((key == 'D' || key == 'd') && state.equals("map_views")) {

    remove_view();
    view_index = view_index < config_values.getJSONObject(state).size() - 1 ? view_index : config_values.getJSONObject(state).size() - 1;
    view = get_view_values();
    map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
    saveJSONObject(config_values, "data/config/values.json");

  } else if ((key == 'N' || key == 'n') && state.equals("map_views")) {

    add_view();
    view_index = view_index < (config_values.getJSONObject(state).size() - 1) ? view_index + 1 : 0;
    view = get_view_values();

    while (!view.getString("title").equals("My New View")){

      view_index = view_index < (config_values.getJSONObject(state).size() - 1) ? view_index + 1 : 0;
      view = get_view_values();

    }

    map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
    mode = "edit";
    saveJSONObject(config_values, "data/config/values.json");

  } else if (((key == 'S' || key == 's')) && state.equals("map_views") && mode.equals("nav")) {

    view_index = 0;
    state = "user_settings";
    view = get_view_values();

  } else if (((key == 'P' || key == 'p')) && (state.equals("map") || state.equals("plot"))) {

    if (state.equals("map")) {

      state = "plot";
      show_guides = false;
      plot_flag = true;

    } else if (state.equals("plot")) {

      state = "map";
      show_guides = true;
      plot_flag = false;
      loop();

    }

  } else if (((key == 'V' || key == 'v')) && state.equals("user_settings") && mode.equals("nav")) {

    view_index = 0;
    state = "map_views";
    view = get_view_values();

  } else if (((key == 'G' || key == 'g')) && (mode.equals("nav") || state.equals("map"))) {

    show_guides = !show_guides;

  } else if (key == 'M' || key == 'm') {
     
     if (state.equals("map_views")) {

      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      state = "map";
      mode = "nav";

    } else if (state.equals("map")) {

      state = "map_views";
      mode = "nav";

    }

  } else if (mode.equals("edit") && (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != LEFT && keyCode != RIGHT)) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("edit")) {

        String edit = get_field();

          if (type_lookup[view_index].equals("string") || type_lookup[view_index].equals("boolean")) {
          
            set_field(edit + key);

          } else if (key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {

            set_field(edit + key);

          }

      } 

    }

  }

}
