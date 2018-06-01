// alpha-- extracts the alpha value -- opacity between 0 and 1
// hue-- extracts the hue value -- colorful or black and white?
// saturation-- extracts the saturation value -- amount of grey

// only works when transparency exist
float alpha_check() {
  float sum = 0;
  for (int i = 0; i < PICSIZE; i++) {
    sum += abs(alpha(input.pixels[i])-alpha(result.pixels[i]));
    //println("hmm? ", alpha(input.pixels[i]));
    //println("ahh! ", alpha(result.pixels[i]));
  }
  float sumavg = sum / PICSIZE;
  float score = sumavg * 100;
  //println("sum: ", sum, " sumavg: ", sumavg, " score: ", score);
  return score;
}

// only works when transparency exist
float hue_check() {
  float input_sum = 0;
  float result_sum = 0;
  for (int i = 0; i < PICSIZE; i++) {
    input_sum += hue(input.pixels[i]);
    result_sum += hue(result.pixels[i]);
  }
  float score = abs((input_sum - result_sum) / input_sum)*100;
  return score;
}

float sat_check() {
  float input_sum = 0;
  float result_sum = 0;
  for (int i = 0; i < PICSIZE; i++) {
    input_sum += saturation(input.pixels[i]);
    result_sum += saturation(result.pixels[i]);
  }
  float score = abs((input_sum - result_sum) / input_sum)*100;
  return score;
}