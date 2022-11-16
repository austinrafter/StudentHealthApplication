package com.example.Controller;

public class ActivityNotFoundException extends RuntimeException{

    ActivityNotFoundException(Long id) {
        super("Could not find activity " + id);
    }

}
