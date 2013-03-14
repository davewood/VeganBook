-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Thu Mar 14 16:23:31 2013
-- 

;
BEGIN TRANSACTION;
--
-- Table: ingredients
--
CREATE TABLE ingredients (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar NOT NULL,
  content varchar NOT NULL
);
--
-- Table: recipes
--
CREATE TABLE recipes (
  id INTEGER PRIMARY KEY NOT NULL,
  name varchar NOT NULL,
  content varchar NOT NULL,
  created timestamp NOT NULL,
  updated timestamp NOT NULL
);
--
-- Table: recipe_ingredients
--
CREATE TABLE recipe_ingredients (
  id INTEGER PRIMARY KEY NOT NULL,
  recipe_id integer NOT NULL,
  ingredient_id integer NOT NULL,
  FOREIGN KEY (ingredient_id) REFERENCES ingredients(id),
  FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX recipe_ingredients_idx_ingredient_id ON recipe_ingredients (ingredient_id);
CREATE INDEX recipe_ingredients_idx_recipe_id ON recipe_ingredients (recipe_id);
CREATE UNIQUE INDEX recipe_ingredients_recipe_id_ingredient_id ON recipe_ingredients (recipe_id, ingredient_id);
COMMIT;
