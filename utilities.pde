void implement_settings() {
  
  JSONObject s = config_settings;

  c_form_background = extract_color(s.getJSONObject("form_background"));
  c_form_text = extract_color(s.getJSONObject("form_text"));
  c_form_active_text = extract_color(s.getJSONObject("form_active_text"));
  c_form_highlight = extract_color(s.getJSONObject("form_highlight"));
  c_form_guide = extract_color(s.getJSONObject("form_guide"));
  c_map_guide = extract_color(s.getJSONObject("map_guide"));
  
  size(1200, 800, P2D);
  bodyFont = createFont("data/fonts/Inter-UI-Regular.ttf", 16, true);
  guideFont = createFont("data/fonts/Inter-UI-Medium.ttf", 14, true);
  // TODO: Handle dimensions & text sizes
  extension = s.getJSONObject("export").getString("extension");
  button = int(s.getJSONObject("form_guide").getString("size"));
  cursor_offset = int(s.getJSONObject("form_cursor").getString("offset"));
  cursor_height = int(s.getJSONObject("form_cursor").getString("height"));
  cursor_width = int(s.getJSONObject("form_cursor").getString("width"));
  margin = int(s.getJSONObject("form_layout").getString("margin"));
  padding = int(s.getJSONObject("form_layout").getString("padding"));
  state = s.getJSONObject("defaults").getString("state");
  mode = s.getJSONObject("defaults").getString("mode");
  show_guides = boolean(s.getJSONObject("defaults").getString("guides"));
  view_index = int(s.getJSONObject("defaults").getString("view"));
  field_index = int(s.getJSONObject("defaults").getString("field"));
  frameRate(int(s.getJSONObject("defaults").getString("rate")));
  
}

void implement_user_settings() {
  
  JSONObject u = config_values.getJSONObject("user_settings");

  c_tint = extract_color(u.getJSONObject("tint"));
  c_point = extract_color(u.getJSONObject("point"));
  c_connector = extract_color(u.getJSONObject("connector"));
  c_title = extract_color(u.getJSONObject("title"));
  c_subtitle = extract_color(u.getJSONObject("subtitle"));
  
  // TODO: Handle dimensions
  point_diameter = u.getJSONObject("point").getInt("size");
  connector_weight = u.getJSONObject("connector").getInt("size");
  
}

String[] list_keys (JSONObject o) {
  
  return (String[]) o.keys().toArray(new String[o.size()]);
  
}

color extract_color (JSONObject c) {
  
  String[] properties = list_keys(c);
  boolean has_alpha = false;
  
  for (int i = 0; i < properties.length; i++) {
    
    if (properties[i].equals("alpha")) {
      
      has_alpha = true;
      break;
      
    }
   
  }
  
  if (has_alpha) {

    return color(int(c.getString("red")), int(c.getString("green")), int(c.getString("blue")), int(c.getString("alpha")));

  } else {

    return color(int(c.getString("red")), int(c.getString("green")), int(c.getString("blue")));

  }
  
}

//void initialize_markers (JSONArray d, SimplePointMarker[] p) {
//
//  for (int i = 0; i < data.size(); i++) {
//    
//    JSONObject this_location = d.getJSONObject(i);
//    float this_latitude = this_location.getInt("latitudeE7") / 1E7;
//    float this_longitude = this_location.getInt("latitudeE7") / 1E7;
//    p[i] = new SimplePointMarker(new Location(this_latitude, this_longitude));
//  
//  }
//
//}

void initialize_markers (Table d, SimplePointMarker[] p) {

  for (int i = 0; i < data.getRowCount(); i++) {
    
    TableRow row = data.getRow(i);
    Float this_latitude = row.getFloat("latitude");
    Float this_longitude = row.getFloat("longitude");
    p[i] = new SimplePointMarker(new Location(this_latitude, this_longitude));
  
  }

}

void update_step () {

  step = config_settings.getJSONObject("map_movement").getFloat(str(view.getInt("zoom")));

}

JSONObject get_view_values(JSONObject v, int i) {
  
  String[] properties = list_keys(v);
  return v.getJSONObject(properties[i]);
  
}

String get_field() {

  String property = field_lookup[field_index];
  return view.getString(property);

}

void set_field(String s) {

  String property = field_lookup[field_index];
  view.setString(property, s);

}

// TODO: Need to fix for new format
//void add_view() {
//  
//  JSONObject new_view = new JSONObject();
//  new_view.setString("label", "My New View");
//  new_view.setString("lat", "37");
//  new_view.setString("lng", "-95");
//  new_view.setString("zoom", "4");
//  new_view.setString("file", "mynewview");
//  views.append(new_view);
//
//}
