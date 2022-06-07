package com.example.Controller;

import com.example.Model.*;
import com.example.Repository.MeditationRepository;
import com.example.Repository.UserMeditatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping(path = "/meditations")
public class MeditationController {

    @Autowired
    private MeditationRepository meditationRepository;

    @Autowired
    private UserMeditatingRepository userMeditatingRepository;

    @GetMapping
    public List<Meditation> getMeditations(){
        return meditationRepository.findAll();
    }

    @GetMapping
    public List<UserMeditating> getUserMeditations(){
        return userMeditatingRepository.findAll();
    }

    @PostMapping("/addmeditation")
    public Meditation addMeditation(@RequestBody Meditation meditation){
        return meditationRepository.save(meditation);
    }

    @PostMapping("/addmeditationtouser")
    public UserMeditating addUserMeditation(@RequestBody Meditation meditation,@RequestBody Student student,@RequestBody LocalDateTime start){
        return userMeditatingRepository.save(new UserMeditating(meditation, student, start, start));
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateTask(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userMeditatingRepository.existsById(id);
        if(exist){
            UserMeditating userMeditating = userMeditatingRepository.getById(id);
            userMeditating.setEndedAt(ended);
            userMeditatingRepository.save(userMeditating);
            return new ResponseEntity<>("Finished the exercise", HttpStatus.OK);
        }
        return new ResponseEntity<>("Did not begin an exercise", HttpStatus.BAD_REQUEST);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteTask(@PathVariable Long id){
        boolean exist = userMeditatingRepository.existsById(id);
        if(exist){
            userMeditatingRepository.deleteById(id);
            return new ResponseEntity<>("Exercise deleted for user", HttpStatus.OK);
        }
        return new ResponseEntity<>("Exercise did not exist for user", HttpStatus.BAD_REQUEST);
    }
}
