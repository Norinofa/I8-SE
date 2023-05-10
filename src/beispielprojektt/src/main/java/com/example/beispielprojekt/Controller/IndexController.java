package com.example.beispielprojekt.Controller;

import com.opencsv.bean.CsvToBean;
import com.opencsv.bean.CsvToBeanBuilder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;


@Controller
public class IndexController {




    @GetMapping("/uploadFile")
    public String uploadFile(){
        return "uploadFile";
    }

    @PostMapping("/uploadFile")
    public String uploadFile(@RequestParam("file") MultipartFile file) throws IOException {
        String uploadDirectory = "C:/uploads/";
        String fileName = file.getOriginalFilename();
        String filePath = Paths.get(uploadDirectory, fileName).toString();
        File dest = new File(filePath);
        file.transferTo(dest);
        return "redirect:/showTextFile";
    }




    @GetMapping("/showTextFile")
    public String getText(Model model) throws IOException {

        String path = "C:/uploads/CSV-SE2-Test_1.csv";
        List<String> lines = Files.readAllLines(Paths.get(path), StandardCharsets.UTF_8);
        model.addAttribute("lines", lines);
        return "showTextFile";
    }


    @GetMapping("/")
    public String index() {
        return "index";
    }

    @PostMapping("/upload-csv-file")
    public String uploadCSVFile(@RequestParam("file") MultipartFile file, Model model) {

        // validate file
        if (file.isEmpty()) {
            model.addAttribute("message", "Please select a CSV file to upload.");
            model.addAttribute("status", false);
        } else {

            // parse CSV file to create a list of `User` objects
            try (Reader reader = new BufferedReader(new InputStreamReader(file.getInputStream()))) {

                // create csv bean reader
                CsvToBean<Student> csvToBean = new CsvToBeanBuilder(reader)
                        .withType(Student.class)
                        .withIgnoreLeadingWhiteSpace(true)
                        .withSeparator(';')
                        .build();

                // convert `CsvToBean` object to list of users
                List<Student> students = csvToBean.parse();


                // save users list on model
                model.addAttribute("students", students);
                model.addAttribute("status", true);



            } catch (Exception ex) {
                model.addAttribute("message", "An error occurred while processing the CSV file.");
                model.addAttribute("status", false);
            }
        }

        return "file-upload-status";
    }

}

