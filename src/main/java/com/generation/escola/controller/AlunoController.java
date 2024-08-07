package com.generation.escola.controller;

import com.generation.escola.model.Aluno;
import com.generation.escola.service.AlunoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/alunos")
@Api(value = "Aluno Management System")
public class AlunoController {

    @Autowired
    private AlunoService alunoService;

    @GetMapping
    @ApiOperation(value = "View a list of available students", response = List.class)
    public List<Aluno> getAllAlunos() {
        return alunoService.findAll();
    }

    @GetMapping("/{id}")
    @ApiOperation(value = "Get a student by Id")
    public Aluno getAlunoById(@PathVariable Long id) {
        return alunoService.findById(id);
    }

    @PostMapping
    @ApiOperation(value = "Add a student")
    public Aluno createAluno(@RequestBody Aluno aluno) {
        return alunoService.save(aluno);
    }

    @PutMapping("/{id}")
    @ApiOperation(value = "Update a student")
    public Aluno updateAluno(@PathVariable Long id, @RequestBody Aluno aluno) {
        Aluno existingAluno = alunoService.findById(id);
        if (existingAluno != null) {
            aluno.setId(id);
            return alunoService.save(aluno);
        }
        return null;
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "Delete a student")
    public void deleteAluno(@PathVariable Long id) {
        alunoService.deleteById(id);
    }
}
