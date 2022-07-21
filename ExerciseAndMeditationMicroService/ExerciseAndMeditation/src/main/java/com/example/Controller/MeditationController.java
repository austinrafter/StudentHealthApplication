package com.example.Controller;

import com.example.Model.*;
import com.example.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.time.format.DateTimeFormatter;

@RestController
@RequestMapping(path = "/meditations")
public class MeditationController {

    @Autowired
    private MeditationRepository meditationRepository;

    @Autowired
    private UserMeditatingRepository userMeditatingRepository;

    @Autowired
    private PassMeditationRepository passMeditationRepository;

    @Autowired
    private StudentRepository studentRepository;

    @GetMapping("/getMeditations")
    public List<Meditation> getMeditations(){
        System.out.println("gets here: get meditations");
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
    public PassMeditation addUserMeditation(@RequestBody PassMeditation passMeditation){
        List<Meditation> meditations = meditationRepository.findByMeditationname(passMeditation.getMeditationname());
        List<Student> students = studentRepository.findByUsername(passMeditation.getUsername());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        LocalDateTime dateTimeStarted = LocalDateTime.parse(passMeditation.getStartedat(), formatter);
        LocalDateTime dateTimeEnded = LocalDateTime.parse(passMeditation.getEndedat(), formatter);
        UserMeditating userMeditating = new UserMeditating(meditations.get(0), students.get(0), dateTimeStarted, dateTimeEnded, passMeditation.getTotaltime());
        userMeditatingRepository.save(userMeditating);
        return passMeditationRepository.save(passMeditation);
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
