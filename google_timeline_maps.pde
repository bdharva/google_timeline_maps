import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.marker.*;

String state, mode;
float step;
int button, cursor_offset, cursor_height, cursor_width, input_steps, iterator, margin, padding, view_index, field_index, point_diameter, airport_diameter, connector_weight, flight_weight;
boolean guide_flag;
JSONArray guides, settings, views;
JSONObject config, dimensions, tint, view;
PFont bodyFont, guideFont;
String extension, target;
color c_title, c_subtitle, c_form, c_form_text, c_form_active, c_form_highlight, c_guide, c_map_guide, c_tint, c_point, c_line, c_flight, c_airport;
Table data = new Table();
SimplePointMarker[] points;

UnfoldingMap map;

void setup() {

  state = "views";
  mode = "nav";
  
  extension = ".jpg";
  
  guide_flag = true;
  
  button = 30;
  cursor_offset = 1;
  cursor_height = 20;
  cursor_width = 2;
  input_steps = 9;
  iterator = 0;
  margin = 40;
  padding = 20;
  step = 1;
  view_index = 0;
  field_index = 0;
  
  config = loadJSONObject("config/test.json");
  
  guides = config.getJSONArray("guides");
  settings = config.getJSONArray("settings");
  views = config.getJSONArray("views");
  
  update_colors(settings);
  update_markers(settings);
  
  println(point_diameter);
  
  size(1200, 800, P2D);
  frameRate(60);
  
  bodyFont = createFont("Inter-UI-Regular", 16, true);
  guideFont = createFont("Inter-UI-Medium", 14, true);
  
  //map = new UnfoldingMap(this, new Microsoft.RoadProvider());
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  view = get_view_values(views, view_index);
  map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
  
  data = loadTable("google/location_history_cleaned.csv", "header");
  
  points = new SimplePointMarker[data.getRowCount()];
  
  for (int i = 0; i < data.getRowCount(); i++) {
  
    TableRow row = data.getRow(i);
    float this_latitude = row.getFloat("latitude");
    float this_longitude = row.getFloat("longitude");
    Location this_location = new Location(this_latitude, this_longitude);
    points[i] = new SimplePointMarker(this_location);
  
  }
  
}

void draw() {

  draw_form(state, mode);
  
}

void update_colors(JSONArray s) {
  
  for (int i = 0; i < s.size(); i++) {
    
    String name = s.getJSONObject(i).getString("name");
    JSONArray fields = s.getJSONObject(i).getJSONArray("fields");  
    
    if (name.equals("title")) {
      
      c_title = extract_rgba(fields);
    
    } else if (name.equals("subtitle")) {
    
      c_subtitle = extract_rgba(fields);
    
    } else if (name.equals("form")) {
    
      c_form = extract_rgb(fields);
    
    } else if (name.equals("form_text")) {
    
      c_form_text = extract_rgb(fields);
    
    } else if (name.equals("form_active")) {
    
      c_form_active = extract_rgb(fields);
    
    } else if (name.equals("form_highlight")) {
    
      c_form_highlight = extract_rgb(fields);
    
    } else if (name.equals("form_guide")) {
    
      c_guide = extract_rgb(fields);
    
    } else if (name.equals("map_guide")) {
    
      c_map_guide = extract_rgb(fields);
    
    } else if (name.equals("tint")) {
    
      c_tint = extract_rgb(fields);
    
    } else if (name.equals("point")) {
    
      c_point = extract_rgba(fields);
    
    } else if (name.equals("connector")) {
    
      c_line = extract_rgba(fields);
    
    } else if (name.equals("flight")) {
    
      c_flight = extract_rgba(fields);
    
    } else if (name.equals("airport")) {
    
      c_airport = extract_rgba(fields);
    
    }
  
  }
  
}

color extract_rgb (JSONArray c) {
  
  int r = 0, g = 0, b = 0;
  
  for (int i = 0; i < c.size(); i++) {
    
    JSONObject this_color = c.getJSONObject(i);
    
    if(this_color.getString("name").equals("red")) {
      
      r = this_color.getInt("value");
      
    } else if(this_color.getString("name").equals("green")) {
      
      g = this_color.getInt("value");
      
    } else if(this_color.getString("name").equals("blue")) {
      
      b = this_color.getInt("value");
      
    }
    
  }
  
  return color(r, g, b);
  
}

color extract_rgba (JSONArray c) {
  
  int r = 0, g = 0, b = 0, a = 0;
  
  for (int i = 0; i < c.size(); i++) {
    
    JSONObject this_color = c.getJSONObject(i);
    
    if(this_color.getString("name").equals("red")) {
      
      r = this_color.getInt("value");
      
    } else if(this_color.getString("name").equals("green")) {
      
      g = this_color.getInt("value");
      
    } else if(this_color.getString("name").equals("blue")) {
      
      b = this_color.getInt("value");
      
    } else if(this_color.getString("name").equals("alpha")) {
      
      a = this_color.getInt("value");
      
    }
    
  }
  
  return color(r, g, b, a);
  
}

void update_markers(JSONArray s) {
  
  for (int i = 0; i < s.size(); i++) {
    
    String name = s.getJSONObject(i).getString("name");
    JSONArray fields = s.getJSONObject(i).getJSONArray("fields");  
    
    if (name.equals("point")) {
    
      point_diameter = extract_marker(fields, "diameter");
    
    } else if (name.equals("connector")) {
    
      connector_weight = extract_marker(fields, "weight");
    
    } else if (name.equals("flight")) {
    
      flight_weight = extract_marker(fields, "weight");
    
    } else if (name.equals("airport")) {
    
      airport_diameter = extract_marker(fields, "diameter");
    
    }
  
  }
  
}

int extract_marker(JSONArray m, String s) {
  
  int return_value = 0;
  
  for (int i = 0; i < m.size(); i++) {
    
    JSONObject this_marker = m.getJSONObject(i);
    
    if(this_marker.getString("name").equals(s)) {
      
      return_value = this_marker.getInt("value");
      break;
      
    }
    
  }
  
  return return_value;
  
}

void draw_form(String s, String m) {
  
  if (s.equals("views")) {
    
    background(c_form);
    fill(c_form_active);
    textFont(guideFont);
    textAlign(RIGHT, TOP);
    text("View " + str(view_index + 1) + " of " + str(views.size()), width - margin, margin);
    
    JSONArray fields = views.getJSONObject(view_index).getJSONArray("fields");
      
    for (int i = 0; i < fields.size(); i++) {
        
      render_field(fields.getJSONObject(i), i, 2, m);
        
    }
    
  } else if (s.equals("settings")) {
    
    background(c_form);
    fill(c_form_active);
    textFont(guideFont);
    textAlign(RIGHT, TOP);
    text("Setting " + str(view_index + 1) + " of " + str(settings.size()), width - margin, margin);
    
    JSONArray fields = settings.getJSONObject(view_index).getJSONArray("fields");
      
    for (int i = 0; i < fields.size(); i++) {
        
      render_field(fields.getJSONObject(i), i, 3, m);
        
    }
    
  } else if (s.equals("map")) {
    
    draw_map();
    
  }
  
  if (guide_flag) {
    
    for (int i = 0; i < guides.size(); i++) {
        
      if (guides.getJSONObject(i).getString("state").equals(s) && guides.getJSONObject(i).getString("mode").equals(m)) {
        
        JSONArray guide_group = guides.getJSONObject(i).getJSONArray("guides");
        
        for (int j = 0; j < guide_group.size(); j++) {
        
          render_guide(guide_group.getJSONObject(j), j, 5, guide_group.size());
          
        }
        
      }
        
    }
    
  }
  
}

void render_field(JSONObject f, int i, int c, String m) {
  
  int row = i == 0 ? 0 : floor((i + c - 1) / c);
  int col = i == 0 ? 0 : (i + c - 1) % c;
  int offset_y = 5 * padding;
  float column_x = (width - (c + 1) * margin)/c;
  float x_0 = col * (column_x + margin) + margin;
  float y_0 = 3 * margin / 2 + row * offset_y;
  float x_1 = i == 0 ? width - margin : x_0 + column_x;
  
  textFont(bodyFont);
  textAlign(LEFT, CENTER);
  
  if (mode.equals("edit") && field_index == i) {
    
    fill(c_form_highlight);
    
  } else {
    
    fill(c_form_text);
    
  }
  
  if (boolean(f.getString("editable"))){
  
    text(f.getString("label"), x_0, y_0);
    rectMode(CORNERS);
    noStroke();
    rect(x_0, y_0 + 3 * padding, x_1, y_0 + 3 * padding - 2);
    
  }
  
  if ((mode.equals("edit") && field_index == i) || mode.equals("nav") || !boolean(f.getString("editable"))) {
    
    fill(c_form_active);
    
  } else {
    
    fill(c_form_text);
    
  }
  
  String type = f.getString("type");
  float sw = 0;
  
  text(f.getString("value"), x_0, y_0 + 2 * padding);
  sw = textWidth(f.getString("value"));
  
  if ((mode.equals("edit") && field_index == i)) {
    
    fill(c_form_active);
    
  } else {
    
    fill(c_form_text);
    
  }
  
  textAlign(RIGHT, CENTER);
  text(f.getString("helper"), x_1, y_0 + 2 * padding);
  
  if (mode.equals("edit") && field_index == i) {
    
    fill(c_form_text);
    rect(x_0 + sw + cursor_offset, y_0 + 2 * padding - cursor_height / 2 + 2, x_0 + sw + cursor_offset + cursor_width, y_0 + 2 * padding + cursor_height / 2 + 2);

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
    
    stroke(c_guide);
    
  }
  
  strokeWeight(1);
  rect(x_0, y_0, x_0 + button, y_0 + button, 4);
  noStroke();
  
  if (state.equals("map")) {
    
   fill(c_map_guide);
   
  } else {
    
    fill(c_guide);
    
  }
  
  textFont(guideFont);
  textAlign(CENTER, CENTER);
  text(h.getString("icon"), x_0 + button / 2, y_0 + button / 2 - 2);
  textAlign(LEFT, CENTER);
  text(h.getString("text"), x_1, y_0 + button / 2 - 2);

}

JSONObject get_view_values(JSONArray v, int i) {
  
  JSONArray fields = v.getJSONObject(i).getJSONArray("fields");
  JSONObject result = new JSONObject();
  
  for (int j = 0; j < fields.size(); j++){
    
    JSONObject field = fields.getJSONObject(j);
    
    String type = field.getString("type");
    
    if (type.equals("float")) {
        
      result.setFloat(field.getString("name"), field.getFloat("value"));
      
    } else if (type.equals("int")) {
        
      result.setInt(field.getString("name"), field.getInt("value"));
      
    } else if (type.equals("string")) {
        
      result.setString(field.getString("name"), field.getString("value"));
      
    } else if (type.equals("boolean")) {
        
      result.setBoolean(field.getString("name"), field.getBoolean("value"));
      
    }
    
  }
  
  return result;
  
}

void draw_map() {
  
  // TODO: Load tint
  for (int i = 0; i < settings.size(); i++) {
    
    if(settings.getJSONObject(i).getString("name").equals("tint")) {
      
      JSONArray fields = settings.getJSONObject(i).getJSONArray("fields");
      int r = 0, g = 0, b = 0;
      boolean enabled = true;
      
      for (int j = 0; j < fields.size(); j++) {
        
        JSONObject field = fields.getJSONObject(j);
        if(field.getString("name").equals("enabled")) {
          
          if(boolean(field.getString("value"))) {
            
            c_tint = extract_rgb(fields);
            tint(c_tint);
          }
        }
      }
    }
  }
  
  map.draw();
  
}

// TODO: Need to fix for new format
void add_view() {
  
  JSONObject new_view = new JSONObject();
  new_view.setString("label", "My New View");
  new_view.setString("lat", "37");
  new_view.setString("lng", "-95");
  new_view.setString("zoom", "4");
  new_view.setString("file", "mynewview");
  views.append(new_view);

}

void draw_data() {
  // TODO: Plot shit
  noLoop();
  draw_lines();
  draw_points();
}

void draw_lines() {

  for (int i = 0; i < points.length - 1; i++) {

    try {
      ScreenPosition this_position = points[i].getScreenPosition(map);
      ScreenPosition next_position = points[i + 1].getScreenPosition(map);
  
      noFill();
      stroke(c_line);
      strokeWeight(connector_weight);
      line(this_position.x, this_position.y, next_position.x, next_position.y);
    } catch (NullPointerException npe) {
      break;
    }

  }

}

void draw_points() {

  for (int i = 0; i < points.length; i++) {

    try{
      ScreenPosition this_position = points[i].getScreenPosition(map);
  
      fill(c_point);
      noStroke();
      ellipse(this_position.x, this_position.y, point_diameter, point_diameter);
    } catch (NullPointerException npe) {
      break;
    }

  }

}

void keyPressed() {
  
  if ((state.equals("views") || state.equals("settings")) && mode.equals("edit")) {
    
    if (keyCode == BACKSPACE) {
  
      JSONObject field = new JSONObject();
      
      if (state.equals("views")) {
      
        field = views.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
        
      } else if (state.equals("settings")) {
        
        field = settings.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
        
      }
      
      if (field.getString("value").length() > 0) {
      
        field.setString("value", field.getString("value").substring(0, field.getString("value").length()-1));
        
      }

    } else if (keyCode == DELETE) {
  
      JSONObject field = settings.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
      field.setString("value", "");

    } else if (keyCode == ENTER) {
      
      if (state.equals("settings")) {
        
        update_colors(settings);
        update_markers(settings);
        
      }
      
      mode = "nav";
      saveJSONObject(config, "config/test.json");
      
    } else if (keyCode == RIGHT) {
      
      // TODO: Skip non-editable fields
      
      if (state.equals("views")){
        
        field_index = field_index < (views.getJSONObject(view_index).getJSONArray("fields").size() - 1) ? field_index + 1 : 0;
        
      } else if (state.equals("settings")){
        
        field_index = field_index < (settings.getJSONObject(view_index).getJSONArray("fields").size() - 1) ? field_index + 1 : 0;
        
      }
      
    } else if (keyCode == LEFT) {
      
      // TODO: Skip non-editable fields
      
      field_index = field_index > 0 ? field_index - 1 : views.getJSONObject(view_index).getJSONArray("fields").size() - 1;
      
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != LEFT && keyCode != RIGHT) {
      
      if (state.equals("views")) {
        
        JSONObject field = views.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
        field.setString("value", field.getString("value") + key);
        
      } else if (state.equals("settings")) {
        
        JSONObject field = settings.getJSONObject(view_index).getJSONArray("fields").getJSONObject(field_index);
        field.setString("value", field.getString("value") + key);
        
      }

    }

  } else if ((state.equals("views") || state.equals("settings")) && mode.equals("nav")) {
    
    if (keyCode == ENTER) {
      
      mode = "edit";
      field_index = 0;
    
    } else if (keyCode == RIGHT) {
      
      if (state.equals("views")){
        
        view_index = view_index < (views.size() - 1) ? view_index + 1 : 0;
        view = get_view_values(views, view_index);
        map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
        
      } else if (state.equals("settings")){
        
        view_index = view_index < (settings.size() - 1) ? view_index + 1 : 0;
        
      }
    
    } else if (keyCode == LEFT) {
      
      if (state.equals("views")){
        
        view_index = view_index > 0 ? view_index - 1 : views.size() - 1;
        view = get_view_values(views, view_index);
        map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
        
      } else if (state.equals("settings")){
        
        view_index = view_index > 0 ? view_index - 1 : settings.size() - 1;
        
      }
    
    } else if ((key == 'M' || key == 'm') && state.equals("views")) {
      
      state = "map";
      mode = "nav";
    
    } else if ((key == 'D' || key == 'd') && state.equals("views")) {
      
      if (views.size() > 1) {
    
        views.remove(view_index);
        view_index = view_index < (views.size() - 1) ? view_index : view_index - 1;
        
      } else {
        
        add_view();
        views.remove(view_index);
        
      }
      
      view = get_view_values(views, view_index);
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config, "config/test.json");
    
    } else if ((key == 'N' || key == 'n') && state.equals("views")) {
      
      add_view();
      view_index = views.size() - 1;
      view = get_view_values(views, view_index);
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      mode = "edit";
      
    } else if ((key == 'S' || key == 's') && state.equals("views")) {
      
      view_index = 0;
      state = "settings";
      
    } else if ((key == 'V' || key == 'v') && state.equals("settings")) {
      
      view_index = 0;
      state = "views";
      
    }
    
  } else if (state.equals("map") && mode.equals("nav")) {
    
      if (keyCode == RIGHT || keyCode == LEFT || keyCode == UP || keyCode == DOWN || key == '_' || key == '-' || key == '+' || key == '=') {
        
        JSONArray fields = views.getJSONObject(view_index).getJSONArray("fields");
        int zoom;
      
        for (int i = 0; i < fields.size(); i++) {
          
          if (fields.getJSONObject(i).getString("name").equals("zoom")) {
            
            zoom = fields.getJSONObject(i).getInt("value");
        
            if (zoom <= 3) {
          
              step = 10;
        
            } else if (zoom > 3 && zoom <= 8) {
          
              step = 1;
        
            } else if (zoom > 8 && zoom <= 12) {
          
              step = .1;
        
            } else if (zoom > 12 && zoom <= 15) {
          
              step = .01;
        
            } else if (zoom > 15 && zoom <= 17) {
          
              step = .001;
        
            } else {
          
              step = .0001;
        
            }
            
            break;
            
          }
          
        }
      
        for (int i = 0; i < fields.size(); i++) {
          
          if (fields.getJSONObject(i).getString("name").equals("longitude") && (keyCode == RIGHT || keyCode == LEFT)) {
    
            if (keyCode == RIGHT) {
              
              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") + step));
      
            } else if (keyCode == LEFT) {
        
              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") - step));
      
            }
            
          } else if (fields.getJSONObject(i).getString("name").equals("latitude") && (keyCode == UP || keyCode == DOWN)) {
        
            if (keyCode == UP) {
        
              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") + step));
      
            } else if (keyCode == DOWN) {
        
              fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getFloat("value") - step));
      
            }
            
          } else if (fields.getJSONObject(i).getString("name").equals("zoom") && (key == '_' || key == '-' || key == '+' || key == '=')) {
        
            if (key == '_' || key == '-') {
        
              if (fields.getJSONObject(i).getInt("value") > 3) {
              
                fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getInt("value") - 1));
                
              }
      
            } else if (key == '+' || key == '=') {
              
              if (fields.getJSONObject(i).getInt("value") < 19) {
        
                fields.getJSONObject(i).setString("value", str(fields.getJSONObject(i).getInt("value") + 1));
                
              }
      
            }
            
          }
          
        }
      
      view = get_view_values(views, view_index);
      map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));
      saveJSONObject(config, "config/test.json");

    } else if (key == 'M' || key == 'm') {
  
      state = "views";
      guide_flag = true;

    } else if (key == 'G' || key == 'g') {
  
      guide_flag = !guide_flag;

    } else if (key == 'P' || key == 'p') {
  
      state = "plot";
      draw_data();

    } //else if (key == 'S' || key == 's') {
  
//      // save("exports/" + file + extension);

//    }

  } else if (state.equals("plot")) {
    
    if (key == 'P' || key == 'p') {
  
      state = "map";
      loop();

    }
    
  }
  
}
