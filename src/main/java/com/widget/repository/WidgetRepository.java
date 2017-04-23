package com.widget.repository;

import com.widget.domain.Widget;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface WidgetRepository extends MongoRepository<Widget, String> {
    List<Widget> findByName(@Param("name") String name);
}
