package com.example.sleep.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@RequiredArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "sleep")
public class Sleep {
    @Getter
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Getter
    @Setter
    @NonNull
    @Column(name = "start")
    private Long start;

    @Getter
    @Setter
    @NonNull
    @Column(name = "end")
    private Long end;
}
