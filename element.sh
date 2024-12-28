#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# global vars
QUERY_ELEMENT="QUERY_ELEMENT"
ATOMIC_NUMBER="ATOMIC_NUMBER"
ATOMIC_SYMBOL="ATOMIC_SYMBOL"
ELEMENT_NAME="ELEMENT_NAME"
ELEMENT_TYPE="ELEMENT_TYPE"
ATOMIC_MASS="ATOMIC_MASS"
MELTING_POINT="MELTING_POINT"
BOILING_POINT="BOILING_POINT"
TYPE_ID="TYPE_ID"

NOT_FOUND() {

  echo -e "\nI could not find that element in the database."
}

QUERY() {

  echo "$QUERY_ELEMENT" | while IFS='|' read ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID; do

    echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
  done

}

# empty arg
if [[ -z $1 ]]; then

  echo -e "\nPlease provide an element as an argument."

# when arg is a number
elif [[ $1 =~ ^[0-9]+$ ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE atomic_number = $1")

  if [[ -z $QUERY_ELEMENT ]]; then

    NOT_FOUND

  else

    echo "$QUERY_ELEMENT" | while IFS='|' read ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID; do

      echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
    done

  fi

# when arg is a char
elif [[ $1 = [[:alpha:]] ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE symbol = '$1'\n")

  if [[ -z $QUERY_ELEMENT ]]; then

    NOT_FOUND

  else

    echo "$QUERY_ELEMENT" | while IFS='|' read ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID; do

      echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
    done

  fi

# when arg is a string
elif [[ ! $1 =~ ^[0-9]+$ ]]; then

  # query database using argument
  QUERY_ELEMENT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) WHERE name = '$1'")

  if [[ -z $QUERY_ELEMENT ]]; then

    NOT_FOUND

  else

    echo "$QUERY_ELEMENT" | while IFS='|' read ATOMIC_NUMBER ATOMIC_SYMBOL ELEMENT_NAME ELEMENT_TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID; do

      echo -e "\nThe element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($ATOMIC_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.\n"
    done

  fi

else

  NOT_FOUND

fi
