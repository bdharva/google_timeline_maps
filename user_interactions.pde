void keyPressed() {
 
  if (keyCode == LEFT) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("nav")) {
    
        view_index = view_index > 0 ? view_index - 1 : config_values.getJSONObject(state).size() - 1;
        view = get_view_values(config_values.getJSONObject(state), view_index);

      } else if (mode.equals("edit")) {

        field_index = field_index > 0 ? field_index - 1 : field_lookup.length - 1;

      }

    } else if (state.equals("map")) {

      view.setFloat("longitude", view.getFloat("longitude") - step);
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      
    }

  } else if (keyCode == RIGHT) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("nav")) {
    
        view_index = view_index < (config_values.getJSONObject(state).size() - 1) ? view_index + 1 : 0;
        view = get_view_values(config_values.getJSONObject(state), view_index);

      } else if (mode.equals("edit")) {

        field_index = field_index < (field_lookup.length - 1) ? field_index + 1 : 0;

      }

    } else if (state.equals("map")) {

      view.setFloat("longitude", view.getFloat("longitude") + step);
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));

    }

  } else if (keyCode == UP) {

    if (state.equals("map")) {

      view.setFloat("latitude", view.getFloat("latitude") + step);
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));

    }

  } else if (keyCode == DOWN) {

    if (state.equals("map")) {

      view.setFloat("latitude", view.getFloat("latitude") - step);
      update_step();
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      
    }

  } else if (keyCode == ENTER) {

    if (state.equals("map_views") || state.equals("user_settings")) {

      if (mode.equals("nav")) {

        mode = "edit";
        field_index = 0;

      } else if (mode.equals("edit")) {

        implement_user_settings();
        //saveJSONObject(config, "data/config/values.json");
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
  } else if (((key == 'S' || key == 's')) && state.equals("map_views") && mode.equals("nav")) {

    view_index = 0;
    state = "user_settings";
    view = get_view_values(config_values.getJSONObject(state), view_index);

  } else if (((key == 'V' || key == 'v')) && state.equals("user_settings") && mode.equals("nav")) {

    view_index = 0;
    state = "map_views";
    view = get_view_values(config_values.getJSONObject(state), view_index);

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
