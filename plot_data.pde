//void draw_map() {
//  
//  // TODO: Load tint
//  for (int i = 0; i < settings.size(); i++) {
//    
//    if(settings.getJSONObject(i).getString("name").equals("tint")) {
//      
//      JSONArray fields = settings.getJSONObject(i).getJSONArray("fields");
//      int r = 0, g = 0, b = 0;
//      boolean enabled = true;
//      
//      for (int j = 0; j < fields.size(); j++) {
//        
//        JSONObject field = fields.getJSONObject(j);
//        if(field.getString("name").equals("enabled")) {
//          
//          if(boolean(field.getString("value"))) {
//            
//            c_tint = extract_rgb(fields);
//            tint(c_tint);
//          }
//        }
//      }
//    }
//  }
//  
//  map.draw();
//  
//}
//
//void draw_data() {
//  // TODO: Plot shit
//  noLoop();
//  draw_lines();
//  draw_points();
//}
//
//void draw_lines() {
//
//  for (int i = 0; i < points.length - 1; i++) {
//
//    try {
//      
//      ScreenPosition this_position = points[i].getScreenPosition(map);
//      ScreenPosition next_position = points[i + 1].getScreenPosition(map);
//      noFill();
//      stroke(c_connector);
//      strokeWeight(connector_weight);
//      line(this_position.x, this_position.y, next_position.x, next_position.y);
//    
//    } catch (NullPointerException npe) {
//    
//      break;
//    
//    }
//
//  }
//
//}
//
//void draw_points() {
//
//  for (int i = 0; i < points.length; i++) {
//
//    try{
//      ScreenPosition this_position = points[i].getScreenPosition(map);
//  
//      fill(c_point);
//      noStroke();
//      ellipse(this_position.x, this_position.y, point_diameter, point_diameter);
//    } catch (NullPointerException npe) {
//      break;
//    }
//
//  }
//
//}
