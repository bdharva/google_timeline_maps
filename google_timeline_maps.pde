import java.util.Iterator;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.marker.*;

boolean plot_flag, show_guides;
color c_connector, c_form_background, c_form_active_text, c_form_text, c_form_guide, c_form_highlight, c_map_guide, c_point, c_tint, c_title, c_subtitle;
int button, connector_weight, cursor_height, cursor_offset, cursor_width, field_index, margin, padding, point_diameter, view_index;
JSONObject config_forms, config_settings, config_values, view;
float step;
PFont body_font, guide_font, title_font, subtitle_font;
SimplePointMarker[] points;
String extension, mode, state, target, view_lookup;
String[] editable_lookup, field_lookup, type_lookup;
Table data;
UnfoldingMap map;

void setup() {

  config_forms = loadJSONObject("data/config/forms.json");
  config_values = loadJSONObject("data/config/values.json");
  config_settings = loadJSONObject("data/config/settings.json");
  implement_settings();
  implement_user_settings();
  
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  view = get_view_values();
  update_step();

  map.zoomAndPanTo(new Location(view.getFloat("latitude"), view.getFloat("longitude")), view.getInt("zoom"));

  data = loadTable("data/google/location_history_cleaned.csv", "header");
  points = new SimplePointMarker[data.getRowCount()];
  initialize_markers(data, points);
  
}

void draw() {

  if (plot_flag) {
    noLoop();
    draw_data();
    save("exports/" + year() + "-" + month() + "-" + day() + "-" + view.getString("file") + config_settings.getJSONObject("export").getString("extension"));
  } else {
    render_ui();
  }
  
}
