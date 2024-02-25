

import 'dart:convert';

DrawRouting drawRoutingFromJson(String str) => DrawRouting.fromJson(json.decode(str));

String drawRoutingToJson(DrawRouting data) => json.encode(data.toJson());

class DrawRouting {
  DrawRouting({
    required this.type,
    required this.features,
    required this.bbox,
    required this.metadata,
  });

  String type;
  List<Feature> features;
  List<double> bbox;
  Metadata metadata;

  factory DrawRouting.fromJson(Map<String, dynamic> json) {
    return DrawRouting(
    type: json["type"],
    features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
    bbox: List<double>.from(json["bbox"].map((x) => x.toDouble())),
    metadata: Metadata.fromJson(json["metadata"]),
  );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "bbox": List<dynamic>.from(bbox.map((x) => x)),
    "metadata": metadata.toJson(),
  };
}

class Feature {
  Feature({
    required this.bbox,
    required this.type,
    required this.properties,
    required this.geometry,
  });

  List<num> bbox;
  String type;
  Properties properties;
  Geometry geometry;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
    bbox: List<double>.from(json["bbox"].map((x) => x.toDouble())),
    type: json["type"],
    properties: Properties.fromJson(json["properties"]),
    geometry: Geometry.fromJson(json["geometry"]),
  );

  Map<String, dynamic> toJson() => {
    "bbox": List<dynamic>.from(bbox.map((x) => x)),
    "type": type,
    "properties": properties.toJson(),
    "geometry": geometry.toJson(),
  };
}

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  List<List<double>> coordinates;
  String type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "type": type,
  };
}

class Properties {
  Properties({
    required this.segments,
    required this.summary,
    required this.wayPoints,
  });

  List<Segment> segments;
  Summary summary;
  List<num> wayPoints;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    segments: List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
    summary: Summary.fromJson(json["summary"]),
    wayPoints: List<int>.from(json["way_points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "segments": List<dynamic>.from(segments.map((x) => x.toJson())),
    "summary": summary.toJson(),
    "way_points": List<dynamic>.from(wayPoints.map((x) => x)),
  };
}

class Segment {
  Segment({
    required this.distance,
    required this.duration,
    required this.steps,
  });

  num distance;
  num duration;
  List<Step> steps;

  factory Segment.fromJson(Map<String, dynamic> json) => Segment(
    distance: json["distance"].toDouble(),
    duration: json["duration"],
    steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
  };
}

class Step {
  Step({
    required this.distance,
    required this.duration,
    required this.type,
    required this.instruction,
    required this.name,
    required this.wayPoints,
  });

  num distance;
  num duration;
  num type;
  String instruction;
  String name;
  List<num> wayPoints;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: json["distance"].toDouble(),
    duration: json["duration"].toDouble(),
    type: json["type"],
    instruction: json["instruction"],
    name: json["name"],
    wayPoints: List<int>.from(json["way_points"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
    "type": type,
    "instruction": instruction,
    "name": name,
    "way_points": List<dynamic>.from(wayPoints.map((x) => x)),
  };
}

class Summary {
  Summary({
    required this.distance,
    required this.duration,
  });

  num distance;
  num duration;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    distance: json["distance"].toDouble(),
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance,
    "duration": duration,
  };
}

class Metadata {
  Metadata({
    required this.attribution,
    required this.service,
    required this.timestamp,
    required this.query,
    required this.engine,
  });

  String attribution;
  String service;
  num timestamp;
  Query query;
  Engine engine;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    attribution: json["attribution"],
    service: json["service"],
    timestamp: json["timestamp"],
    query: Query.fromJson(json["query"]),
    engine: Engine.fromJson(json["engine"]),
  );

  Map<String, dynamic> toJson() => {
    "attribution": attribution,
    "service": service,
    "timestamp": timestamp,
    "query": query.toJson(),
    "engine": engine.toJson(),
  };
}

class Engine {
  Engine({
    required this.version,
    required this.buildDate,
    required this.graphDate,
  });

  String version;
  DateTime buildDate;
  DateTime graphDate;

  factory Engine.fromJson(Map<String, dynamic> json) => Engine(
    version: json["version"],
    buildDate: DateTime.parse(json["build_date"]).toLocal(),
    graphDate: DateTime.parse(json["graph_date"]).toLocal(),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "build_date": buildDate.toIso8601String(),
    "graph_date": graphDate.toIso8601String(),
  };
}

class Query {
  Query({
    required this.coordinates,
    required this.profile,
    required this.format,
  });

  List<List<num>> coordinates;
  String profile;
  String format;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
    profile: json["profile"],
    format: json["format"],
  );

  Map<String, dynamic> toJson() => {
    "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "profile": profile,
    "format": format,
  };
}
