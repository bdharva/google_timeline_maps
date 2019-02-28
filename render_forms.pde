void render_ui(String s, String m) {
  
  if (s.equals("map_views") || s.equals("user_settings")) {
    
    background(c_form_background);
    fill(c_form_active_text);
    textFont(guideFont);
    textAlign(RIGHT, TOP);
    // TODO: Prettify state
    text(s + " " + str(view_index + 1) + " of " + str(config_values.getJSONObject(s).size()), width - margin, margin);
    
    JSONObject fields = config_forms.getJSONObject(s).getJSONObject("fields");
    JSONArray order = config_forms.getJSONObject(s).getJSONArray("field_order");
    String properties = join(list_keys(view), " "); 
    render_fields(fields, order, view, properties, m);
    
  } else if (s.equals("map")) {
    
    draw_map();
    
  } else if (s.equals("data")) {
    
    //draw_data_ingestion();
    
  }
  
  if (show_guides) {
    
    render_guides(s, m);
    
  }
  
}

void render_fields(JSONObject f, JSONArray o, JSONObject v, String p, String m) {

  int j = 0;
  field_lookup = new String[0];
  type_lookup = new String[0];
  editable_lookup = new String[0];

  for(int i = 0; i < o.size(); i++) {

    if(p.contains(o.getString(i))) {
    
      String property = o.getString(i);
      field_lookup = append(field_lookup, property);
      JSONObject field = f.getJSONObject(property);
      String type = field.getString("type");
      type_lookup = append(type_lookup, type);
      String is_editable = field.getString("editable");
      editable_lookup = append(editable_lookup, is_editable);
      String value = v.getString(property);
      render_field(field, value, j, 2, m);
      j++;

    }
    
  }

}

void render_field(JSONObject f, String v, int i, int c, String m) {
  
  int row = i == 0 ? 0 : floor((i + c - 1) / c);
  int col = i == 0 ? 0 : (i + c - 1) % c;
  int offset_y = 5 * padding;
  float column_x = (width - (c + 1) * margin)/c;
  float x_0 = col * (column_x + margin) + margin;
  float y_0 = 3 * margin / 2 + row * offset_y;
  float x_1 = i == 0 ? width - margin : x_0 + column_x;

  textFont(bodyFont);
  textAlign(LEFT, CENTER);

  if (m.equals("edit") && field_index == i) {
    
    fill(c_form_highlight);
    
  } else {
    
    fill(c_form_text);
    
  }
  
  if (f.getBoolean("editable")){
  
    text(f.getString("label"), x_0, y_0);
    rectMode(CORNERS);
    noStroke();
    rect(x_0, y_0 + 3 * padding, x_1, y_0 + 3 * padding - 2);
    
  }
  
  if ((m.equals("edit") && field_index == i) || mode.equals("nav") || !f.getBoolean("editable")) {
    
    fill(c_form_active_text);
    
  } else {
    
    fill(c_form_text);
    
  }
  
  text(v, x_0, y_0 + 2 * padding);
  
  if ((mode.equals("edit") && field_index == i)) {
    
    fill(c_form_active_text);
    
  } else {
    
    fill(c_form_text);
    
  }
  
  textAlign(RIGHT, CENTER);
  text(f.getString("helper"), x_1, y_0 + 2 * padding); // TODO: Hide if not editable
  
  if (mode.equals("edit") && field_index == i) {
    
    fill(c_form_text);
    rect(x_0 + textWidth(v) + cursor_offset, y_0 + 2 * padding - cursor_height / 2 + 2, x_0 + textWidth(v) + cursor_offset + cursor_width, y_0 + 2 * padding + cursor_height / 2 + 2);

  }
  
}

void render_guides(String s, String m) {

  JSONArray guides = config_forms.getJSONObject(s).getJSONObject("guides").getJSONArray(m);

  for (int i = 0; i < guides.size(); i++) {
    
    render_guide(guides.getJSONObject(i), i, 5, guides.size());
    
  }

}

void render_guide(JSONObject h, int i, int c, int n) {
  
  float row = floor(i / c);
  float col = i % c;
  float rows = c > 4 ? ceil(n / c) + 1 : ceil(n / c);
  int offset_y = button + padding;
  float column_x = (width - (c + 1) * margin)/c;
  float x_0 = col * (column_x + margin) + margin;
  float y_0 = height - margin - rows * offset_y + padding + row * offset_y;
  float x_1 = x_0 + button + padding / 2;
  
  rectMode(CORNERS);
  noFill();
  
  if (state.equals("map")) {
    
   stroke(c_map_guide);
   
  } else {
    
    stroke(c_form_guide);
    
  }
  
  strokeWeight(1);
  rect(x_0, y_0, x_0 + button, y_0 + button, 4);
  noStroke();
  
  if (state.equals("map")) {
    
   fill(c_map_guide);
   
  } else {
    
    fill(c_form_guide);
    
  }
  
  textFont(guideFont);
  textAlign(CENTER, CENTER);
  text(h.getString("icon"), x_0 + button / 2, y_0 + button / 2 - 2);
  textAlign(LEFT, CENTER);
  text(h.getString("text"), x_1, y_0 + button / 2 - 2);

}

void draw_data_ingestion() {
  
  background(c_form_background);
  File f = dataFile("google/Location History.json");
  fill(100,100,100);
  textFont(bodyFont);
  textAlign(CENTER, CENTER);
  
  if (f.isFile()) {
    
    text(f.getPath() + " exists", width / 2, 40);
    
  } else {
    
    text(f.getPath() + " does not exist", width / 2, 40);
    
  }
  
}
