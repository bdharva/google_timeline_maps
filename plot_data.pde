void draw_map() {

    tint(c_tint);
    map.draw();
 
}

void draw_data() {
  draw_lines();
  draw_points();
}

void draw_lines() {

  for (int i = 0; i < points.length - 1; i++) {

   try {
     
     ScreenPosition this_position = points[i].getScreenPosition(map);
     ScreenPosition next_position = points[i + 1].getScreenPosition(map);
     noFill();
     stroke(c_connector);
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
