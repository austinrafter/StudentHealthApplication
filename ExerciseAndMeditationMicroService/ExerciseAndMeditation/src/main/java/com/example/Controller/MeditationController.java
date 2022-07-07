package com.example.Controller;

import com.example.Model.*;
import com.example.Repository.MeditationRepository;
import com.example.Repository.UserMeditatingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping(path = "/meditations")
public class MeditationController {

    @Autowired
    private MeditationRepository meditationRepository;

    @Autowired
    private UserMeditatingRepository userMeditatingRepository;

    @GetMapping("/getMeditations")
    public List<Meditation> getMeditations(){
        return meditationRepository.findAll();
    }

    @GetMapping("/getUserMeditations")
    public List<UserMeditating> getUserMeditations(){
        return userMeditatingRepository.findAll();
    }

    @PostMapping("/addmeditation")
    public Meditation addMeditation(@RequestBody Meditation meditation){
        return meditationRepository.save(meditation);
    }

    @PostMapping("/addmeditationtouser")
    public UserMeditating addUserMeditation(@RequestBody Meditation meditation,@RequestBody Student student,@RequestBody LocalDateTime start, @RequestBody LocalDateTime end,@RequestBody int totaltime){
        return userMeditatingRepository.save(new UserMeditating(meditation, student, start, end, totaltime));
    }

    @PutMapping("/update/{id}")
    public ResponseEntity updateTask(@PathVariable Long id, @PathVariable LocalDateTime ended){
        boolean exist = userMeditatingRepository.existsById(id);
        if(exist){
            UserMeditating userMeditating = userMeditatingRepository.getById(id);
            userMeditating.setEnded_at(ended);
            userMeditatingRepository.save(userMeditating);
            Duration totalTime = Duration.between(userMeditating.getStarted_at(),userMeditating.getEnded_at());
            return new ResponseEntity<>("Finished meditating for " + totalTime + " minutes.", HttpStatus.OK);
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
