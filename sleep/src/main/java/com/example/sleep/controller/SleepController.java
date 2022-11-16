package com.example.sleep.controller;

import com.example.sleep.model.Sleep;
import com.example.sleep.repository.SleepRepository;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@RestController
@RequestMapping(path = "/sleep")
public class SleepController {

    private final SleepRepository sleepRepository;

    @Autowired
    public SleepController(SleepRepository sleepRepository) {
        this.sleepRepository = sleepRepository;
    }

    @GetMapping
    public List<Sleep> getSleepsAll() {
        return sleepRepository.findSleepsByOrderByEndDesc();
    }

    @GetMapping(params = {"after"})
    public List<Sleep> getSleepsAfter(@RequestParam(name = "after") Long after) {
        return sleepRepository.findSleepsByEndAfterOrderByEndDesc(after);
    }

    @GetMapping(params = {"start", "end"})
    public List<Sleep> getSleepsBetween(@RequestParam(name = "start") Long start, @RequestParam(name = "end") Long end) {
        return sleepRepository.findSleepsByEndBetweenOrderByEndDesc(start, end);
    }

    @PostMapping
    public Sleep addSleep(@RequestBody Sleep newSleep) {
        sleepRepository.save(newSleep);
        return newSleep;
    }
}
