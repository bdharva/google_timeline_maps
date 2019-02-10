void keyPressed() {
 
 if ((state.equals("map_views") || state.equals("settings")) && mode.equals("edit")) {
   
   if (keyCode == BACKSPACE) {
 
     // JSONObject field = new JSONObject();
     
     // if (state.equals("views")) {
     
     //   field = views.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
       
     // } else if (state.equals("settings")) {
       
     //   field = settings.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
       
     // }
     
     // if (field.getString("value").length() > 0) {
     
     //   field.setString("value", field.getString("value").substring(0, field.getString("value").length()-1));
       
     // }

   } else if (keyCode == DELETE) {
 
     // JSONObject field = settings.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
     // field.setString("value", "");

   } else if (keyCode == ENTER) {
     
     implement_settings(config_settings, config_values.getJSONObject("user_settings"));
     //saveJSONObject(config, "data/config/values.json");
     mode = "nav";
     
   } else if (keyCode == RIGHT) {
     
     // TODO: Skip non-editable fields
     
     // if (state.equals("views")){
       
     //   field_index = field_index < (views.getJSONObject(view_index).getJSONArray("fields").size() - 1) ? field_index + 1 : 0;
       
     // } else if (state.equals("settings")){
       
     //   field_index = field_index < (settings.getJSONObject(view_index).getJSONArray("fields").size() - 1) ? field_index + 1 : 0;
       
     // }
     
   } else if (keyCode == LEFT) {
     
     // TODO: Skip non-editable fields
     
     // field_index = field_index > 0 ? field_index - 1 : views.getJSONObject(view_index).getJSONArray("fields").size() - 1;
     
   } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != LEFT && keyCode != RIGHT) {
     
     // if (state.equals("views")) {
       
     //   JSONObject field = views.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
     //   field.setString("value", field.getString("value") + key);
       
     // } else if (state.equals("settings")) {
       
     //   JSONObject field = settings.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
     //   field.setString("value", field.getString("value") + key);
       
//     }

   }

 } else if ((state.equals("map_views") || state.equals("settings")) && mode.equals("nav")) {
   
   if (keyCode == ENTER) {
     
     mode = "edit";
     field_index = 0;
   
   } else if (keyCode == RIGHT) {
     
     // if (state.equals("views")){
       
     //   view_index = view_index < (views.size() - 1) ? view_index + 1 : 0;
     //   view = get_view_values(views, view_index);
     //   map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
       
     // } else if (state.equals("settings")){
       
     //   view_index = view_index < (settings.size() - 1) ? view_index + 1 : 0;
       
     // }
   
   } else if (keyCode == LEFT) {
     
     // if (state.equals("views")){
       
     //   view_index = view_index > 0 ? view_index - 1 : views.size() - 1;
     //   view = get_view_values(views, view_index);
     //   map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
       
     // } else if (state.equals("settings")){
       
     //   view_index = view_index > 0 ? view_index - 1 : settings.size() - 1;
       
     // }
   
   } else if ((key == 'M' || key == 'm') && state.equals("views")) {
     
     state = "map";
     mode = "nav";
   
   } else if ((key == 'D' || key == 'd') && state.equals("views")) {
     
     // if (views.size() > 1) {
   
     //   views.remove(view_index);
     //   view_index = view_index < (views.size() - 1) ? view_index : view_index - 1;
       
     // } else {
       
     //   add_view();
     //   views.remove(view_index);
       
     // }
     
     // view = get_view_values(views, view_index);
     // map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
     // saveJSONObject(config, "data/config/test.json");
   
   } else if ((key == 'N' || key == 'n') && state.equals("views")) {
     
     // add_view();
     // view_index = views.size() - 1;
     // view = get_view_values(views, view_index);
     // map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
     // mode = "edit";
     
   } else if ((key == 'S' || key == 's') && state.equals("views")) {
     
     // view_index = 0;
     // state = "settings";
     
   } else if ((key == 'V' || key == 'v') && state.equals("settings")) {
     
     // view_index = 0;
     // state = "views";
     
   }
   
 } else if (state.equals("map") && mode.equals("nav")) {
   
//      if (keyCode == RIGHT || keyCode == LEFT || keyCode == UP || keyCode == DOWN || key == '_' || key == '-' || key == '+' || key == '=') {
       
//        JSONArray fields = views.getJSONObject(view_index).getJSONArray("fields");
//        int zoom;
     
//        for (int i = 0; i < fields.size(); i++) {
         
//          if (fields.getJSONObject(i).getString("name").equals("zoom")) {
           
//            zoom = fields.getJSONObject(i).getInt("value");
       
//            // TODO: Clean up
//            step = update_step(settings, zoom);
           
//          }
         
//        }
     
//        for (int i = 0; i < fields.size(); i++) {
         
//          if (fields.getJSONObject(i).getString("name").equals("longitude") && (keyCode == RIGHT || keyCode == LEFT)) {
   
//            if (keyCode == RIGHT) {
             
//              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") + step));
     
//            } else if (keyCode == LEFT) {
       
//              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") - step));
     
//            }
           
//          } else if (fields.getJSONObject(i).getString("name").equals("latitude") && (keyCode == UP || keyCode == DOWN)) {
       
//            if (keyCode == UP) {
       
//              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") + step));
     
//            } else if (keyCode == DOWN) {
       
//              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") - step));
     
//            }
           
//          } else if (fields.getJSONObject(i).getString("name").equals("zoom") && (key == '_' || key == '-' || key == '+' || key == '=')) {
       
//            if (key == '_' || key == '-') {
       
//              if (fields.getJSONObject(i).getInt("value") > 3) {
             
//                fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getInt("value") - 1));
               
//              }
     
//            } else if (key == '+' || key == '=') {
             
//              if (fields.getJSONObject(i).getInt("value") < 19) {
       
//                fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getInt("value") + 1));
               
//              }
     
//            }
           
//          }
         
//        }
     
//      view = get_view_values(views, view_index);
//      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
//      saveJSONObject(config, "data/config/test.json");

//    } else if (key == 'M' || key == 'm') {
 
//      state = "views";
//      show_guides = true;

//    } else if (key == 'G' || key == 'g') {
 
//      show_guides = !show_guides;

//    } else if (key == 'P' || key == 'p') {
 
//      state = "plot";
//      draw_data();

//    } //else if (key == 'S' || key == 's') {
 
// //      // save("exports/" + file + extension);

// //    }

//  } else if (state.equals("plot")) {
   
//    if (key == 'P' || key == 'p') {
 
//      state = "map";
//      loop();

//    }
   
  }
 
}
